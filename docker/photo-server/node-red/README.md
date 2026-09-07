# Databasus → Nextcloud Talk relay (Node-RED)

A minimal, self-hosted Node-RED instance that receives Databasus's backup
webhook, reformats it, and posts a signed message to a Nextcloud Talk
conversation via the Bot API.

## Files
- `compose.yml` — runs Node-RED with your config as environment variables.
- `settings.js` — minimal Node-RED settings; exposes `crypto` to Function nodes for HMAC signing.
- `flows.json` — the actual flow (webhook in → transform/sign → POST to Talk).

## 1. Register a bot in Nextcloud Talk

You need a bot secret before this will work. On the Nextcloud server:

```bash
occ talk:bot:install "Databasus Alerts" "<a-long-random-secret>" "https://your-relay-host:1880/webhook/databasus" --feature=none
```

(The `--feature=none` webhook URL there is actually irrelevant to *this*
setup — that flag is for bots Nextcloud calls *out* to. We only need the
**secret** it prints, and the bot needs to be enabled in the conversation
you want it to post to, via **Conversation settings → Bots**.)

Grab the conversation's token from its URL, e.g.
`https://cloud.example.com/call/abc12345` → token is `abc12345`.

## 2. Fill in `compose.yml`

Edit the `environment:` block:
- `NC_URL` — your Nextcloud base URL, no trailing slash
- `NC_TOKEN` — the conversation token
- `NC_BOT_SECRET` — the secret from step 1

## 3. Start it

```bash
docker compose up -d
```

Node-RED will come up on port 1880 with the flow already imported and
running — no manual flow-building needed. The webhook endpoint is:

```
http://your-host:1880/webhook/databasus
```

## 4. Point Databasus at it

In Databasus, add a **Webhook** notifier for the database(s) you want,
using the URL above.

## 5. Payload shape (confirmed) and inbound auth

The real Databasus webhook body is simple:

```json
{
  "heading": "✅ [Uptime Kuma] DB is online",
  "message": "✅ [Uptime Kuma] DB is back online"
}
```

The flow uses `message` as the Talk text (falling back to `heading` if
`message` is missing), and prefixes the heading in bold if it differs
from the message. If Databasus later sends other fields for other event
types, open the **"Build & sign Talk message"** Function node and adjust
these two lines — nothing else in the flow needs to change:

```js
const heading = body.heading || '';
const message = body.message || heading || '(no message)';
```

Databasus also sends the request with **HTTP Basic Auth**
(`Authorization: Basic ...`) — the username/password you set when
configuring the webhook notifier in Databasus. Set
`DATABASUS_WEBHOOK_USER` / `DATABASUS_WEBHOOK_PASS` in
`compose.yml` to the same values, and the relay's **"Verify Basic
Auth"** node will reject any request (with `401`) that doesn't present
matching credentials. Leave both blank to skip this check (not
recommended if the relay is reachable from outside your network).

## Notes

- The relay acknowledges Databasus with `200 OK` immediately after
  building the Talk request, so a slow/unreachable Nextcloud Talk server
  won't cause Databasus to see the webhook as failed or retry it.
- The flow is declarative (`flows.json`) and lives in version control —
  edit it either through the Node-RED UI or by hand.
- This is much lighter than n8n: one container, no external database,
  flow state is a single JSON file.
- Secrets are passed as environment variables rather than stored in the
  flow file, so `flows.json` is safe to commit.

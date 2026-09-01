# SimpleLogin self-host — mail.jstockley.com

Files in this bundle:

- `compose.yml` — the app stack (Postgres, webapp, email handler, job runner)
- `.env.example` — copy to `.env` and fill in secrets
- `postfix/` — config for the **native** Postfix install on your VPS host

Assumptions baked in (change if wrong):

- VPS is Ubuntu/Debian-based with `apt` and Docker + Docker Compose v2
  already usable (`docker compose version` works)
- Traefik is already running as a container on an external Docker
  network — this assumes it's named `traefik`; check with
  `docker network ls` and edit `compose.yml`'s bottom `networks:` block
  if different, along with the `certresolver` label name
- Port 25 inbound is open on your VPS provider's firewall/security group
  (many providers block outbound 25 to prevent spam, but inbound is
  usually fine — worth double-checking with your provider, e.g.
  DigitalOcean/Vultr/Hetzner docs, since this is the single most common
  self-host blocker)
- At least 2GB RAM on the VPS

## 0. Point DNS at the server

At your DNS provider for jstockley.com, add:

| Type | Host | Value | Priority |
| --- | --- | --- | --- |
| A | mail | `<your VPS IP>` | — |
| MX | mail | `mail.jstockley.com.` | 10 |
| TXT | mail | `v=spf1 mx ~all` | — |
| TXT | `_dmarc.mail` | `v=DMARC1; p=quarantine; adkim=r; aspf=r` | — |
| TXT | `dkim._domainkey.mail` | (generated in step 1 below) | — |

If you're using Cloudflare for DNS, set the `mail` A record to **DNS
only** (grey cloud, not orange/proxied) — Cloudflare's proxy doesn't
work for mail server IPs.

## 1. Generate DKIM keys

```bash
mkdir -p ~/simplelogin-selfhost && cd ~/simplelogin-selfhost
openssl genrsa -out dkim.key -traditional 1024
openssl rsa -in dkim.key -pubout -out dkim.pub.key

# Print the DNS TXT value to paste into the dkim._domainkey.mail record above:
sed "s/-----BEGIN PUBLIC KEY-----/v=DKIM1; k=rsa; p=/g" dkim.pub.key \
  | sed 's/-----END PUBLIC KEY-----//g' | tr -d '\n' | awk 1
```

Verify propagation before moving on:

```bash
dig @1.1.1.1 mail.jstockley.com mx
dig @1.1.1.1 dkim._domainkey.mail.jstockley.com txt
```

## 2. Copy this bundle onto the VPS

Put `compose.yml`, `.env.example`, `postfix/`, and the two
`dkim.key`/`dkim.pub.key` files you just generated into the same
directory on the VPS, e.g. `~/simplelogin-selfhost/`.

```bash
cp .env.example .env
```

Edit `.env` and set real values for `POSTGRES_PASSWORD`, `FLASK_SECRET`
(generate with `openssl rand -hex 32`), and double check `SL_VERSION`
against <https://hub.docker.com/r/simplelogin/app/tags>.

## 3. Install and configure Postfix (native, on the host)

```bash
sudo apt update && sudo apt install -y postfix postfix-pgsql dnsutils
```

Choose **Internet Site** when prompted, accept the proposed system mail name.

```bash
sudo cp postfix/main.cf /etc/postfix/main.cf
sudo cp postfix/pgsql-relay-domains.cf /etc/postfix/pgsql-relay-domains.cf
sudo cp postfix/pgsql-transport-maps.cf /etc/postfix/pgsql-transport-maps.cf
```

Edit the `password` field in both `pgsql-*.cf` files on the host to
match `POSTGRES_PASSWORD` from your `.env`.

If the snakeoil TLS cert doesn't already exist:

```bash
sudo openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
  -keyout /etc/ssl/private/ssl-cert-snakeoil.key \
  -out /etc/ssl/certs/ssl-cert-snakeoil.pem
```

Restart Postfix — **do this after** the `db` container is up in step 4,
since Postfix needs to reach Postgres on `127.0.0.1:5432`:

```bash
sudo systemctl restart postfix
```

## 4. Bring up the database, then run migration + init

```bash
cd ~/simplelogin-selfhost
docker compose up -d db
docker compose --profile tools run --rm migration
docker compose --profile tools run --rm init
```

Now restart Postfix (it needs the `db` container's port up first):

```bash
sudo systemctl restart postfix
```

## 5. Start the rest of the stack

```bash
docker compose up -d
docker compose logs -f
```

Traefik should pick up the `sl-app` container automatically via its
labels and issue a cert for `mail.jstockley.com`.

## 6. Create your account and make it "premium" (free, self-hosted — no payment)

Visit `https://mail.jstockley.com`, sign up, then:

```bash
docker exec -it sl-db psql -U simplelogin simplelogin
UPDATE users SET lifetime = TRUE;
\q
```

This unlocks unlimited aliases, custom domains, and send/reply-from-alias
— for free, since you're self-hosting.

Once your account(s) are created, lock down further signups by
uncommenting the two `DISABLE_*` lines at the bottom of `.env`, then:

```bash
docker compose restart app
```

## 7. Point Bitwarden at your instance

In Bitwarden's username generator: select **SimpleLogin**, set the
self-host server URL to `https://mail.jstockley.com`, and paste the API
key from your SimpleLogin account's API Keys page.

## Known gap: outbound sending

This setup covers receive-and-forward out of the box. To reliably
**send/reply from an alias**, most VPS providers block or throttle
direct outbound port 25, so mail sent straight from Postfix will often
land in spam or get rejected outright. If/when you want that, the common
fix is routing outbound through a transactional relay (e.g. Brevo's free
tier — 300 emails/day) and adding proper SPF/DKIM/DMARC alignment for
it. Happy to walk through that as a follow-up once the base setup is
confirmed working.

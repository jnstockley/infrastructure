# SimpleLogin Setup

This stack assumes, matching the rest of this infra repo:

- Traefik is already running on this host with an external `proxy` network and a
  certresolver named `production`.
- A shared Postgres instance is already running on the external `private` network
  (this repo's `postgres/compose.yml` pattern) — this stack does **not** bring its
  own database.
- You control DNS for the domain you're using for aliases.

Replace `mail.jstockley.com` / `mail.jstockley.com` everywhere below with your real domain.

## 1. DNS records

| Type  | Host                        | Value                                              |
|-------|-----------------------------|-----------------------------------------------------|
| A     | `mail.jstockley.com`           | your server's public IP                             |
| MX    | `mail.jstockley.com`                | `10 mail.jstockley.com.`                                |
| TXT   | `dkim._domainkey.mail.jstockley.com` | `v=DKIM1; k=rsa; p=<DKIM public key, see step 2>`  |
| TXT   | `mail.jstockley.com`                | `v=spf1 mx ~all`                                     |
| TXT   | `_dmarc.mail.jstockley.com`         | `v=DMARC1; p=quarantine; adkim=r; aspf=r`            |

Open inbound ports 25, 80, 443 on this host's firewall. Port 80/443 should already be
open for Traefik.

## 2. Generate a DKIM keypair

```bash
mkdir -p dkim
openssl genrsa -out dkim/dkim.key -traditional 1024
openssl rsa -in dkim/dkim.key -pubout -out dkim/dkim.pub.key

# Print the value for the DKIM TXT record above:
sed "s/-----BEGIN PUBLIC KEY-----/v=DKIM1; k=rsa; p=/g" dkim/dkim.pub.key \
  | sed 's/-----END PUBLIC KEY-----//g' | tr -d '\n' | awk 1
```

1024-bit is intentional here (matches upstream guidance) — some registrars mishandle
long TXT records with a 2048-bit key.

## 3. Create the database on your shared Postgres

```bash
docker exec -it postgres psql -U <your_postgres_admin_user> -d postgres
```

```sql
CREATE ROLE simplelogin WITH LOGIN PASSWORD 'CHANGE_ME_DB_PASSWORD';
CREATE DATABASE simplelogin OWNER simplelogin;
```

Use the same password in `DB_URI` and the `DB_PASSWORD` field in `.env` — they must match.

## 4. Point the cert dumper at your Traefik ACME storage

`postfix-certs` reads Traefik's `acme.json` to reuse the certificate Traefik already
issues for `mail.jstockley.com`, instead of running a second Let's Encrypt client on
this host (which would fight Traefik for port 80/443).

Edit the `postfix-certs` volume in `compose.yml`:

```yaml
volumes:
  - ../traefik/config/certs/acme.json:/traefik-acme/acme.json:ro
```

Change the host-side path to wherever your Traefik stack actually stores `acme.json`.
Confirm the exact certresolver storage path in your `traefik.yml` static config if
you're not sure.

If you don't run Traefik with ACME (e.g. you use split-horizon DNS challenges some
other way, or don't want to share cert material across stacks), you can instead let
Postfix manage its own certificate: remove the `postfix-certs` service, drop
`TLS_CERT_FILE`/`TLS_KEY_FILE` from `.env`, and add `LETSENCRYPT_EMAIL=you@mail.jstockley.com`
instead. This only works if nothing else on the host holds port 80 during
issuance/renewal.

## 5. Find your Docker network subnets

```bash
docker network inspect proxy private | grep -A2 Subnet
```

Update `MYNETWORKS` in `.env` with the actual subnets reported (in addition to the
loopback ranges already listed). This controls which sources Postfix will relay mail
for without restriction — too narrow breaks outbound mail from the app containers,
too broad creates an open relay.

## 6. First boot

```bash
cp sample.env .env
# edit .env: fill in every CHANGE_ME, your real domain, and the values from steps 2-5

mkdir -p data/pgp data/upload data/certs

docker compose up -d
docker compose logs -f migrate init
```

`migrate` and `init` run once and exit — check their logs for a clean exit (0) before
worrying about the other containers. `webapp`, `email-handler`, and `job-runner` won't
start until `init` completes successfully.

## 7. Create your account, then lock down registration

Sign up at `https://mail.jstockley.com` once the webapp is healthy. To give an account
unlimited aliases (premium):

```bash
docker exec -it postgres psql -U <your_postgres_admin_user> -d simplelogin \
  -c "UPDATE users SET lifetime = TRUE WHERE email = 'you@mail.jstockley.com';"
```

Once you and anyone else who needs an account have signed up, close registration by
uncommenting in `.env`:

```
DISABLE_REGISTRATION=1
```

Then: `docker compose up -d webapp` to apply.

## Troubleshooting

- **No mail arriving**: `docker compose logs -f postfix`. Confirm your MX record
  resolves and port 25 is reachable from the internet (`telnet mail.jstockley.com 25`
  from an external host — not from this server, ISPs commonly block outbound 25 for
  the *test* even when inbound works fine).
- **Postfix has no TLS**: check `docker compose logs postfix-certs` — it only produces
  output once Traefik has actually issued a cert for `POSTFIX_FQDN`. Until then,
  Postfix falls back to running without TLS rather than failing to start.
- **`migrate` loops forever waiting for postgres**: confirm `DB_HOST`/`DB_PORT` in
  `.env` match a running, reachable container on the `private` network
  (`docker exec simplelogin-migrate bash -c 'cat /etc/hosts'` can help confirm DNS
  resolution on that network).

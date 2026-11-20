# AdGuard Home

[OpenTofu overview](../README.md)

Manages AdGuard Home's DNS configuration and client policy. The running
server is defined in
[the photo server stack](../../docker/photo-server/adguard/compose.yml).

## Configuration map

| File | Responsibility |
| --- | --- |
| [provider.tofu](provider.tofu) | Provider requirements, HTTP backend, inputs, and API configuration. |
| [config.tofu](config.tofu) | Server-wide DNS settings. |
| [clients.tofu](clients.tofu) | Known clients and their DNS/filtering behavior. |
| [dns-rewrites.tofu](dns-rewrites.tofu) | Internal host records and local wildcard rewrites; exports `local_wildcard` and `host_records`. |
| [rules.tofu](rules.tofu) | Custom filtering rules. |

Provider sources: `gmichels/adguard`. See
`provider.tofu` for version constraints and `.terraform.lock.hcl` for
selected dependency versions.

## Inputs and dependencies

Declared inputs, supplied as `TF_VAR_<name>` or approved local inputs:

- `adguard_username`
- `adguard_password`
- `gitlab_username`
- `gitlab_access_token`

Also supply the backend variables described in the
[shared local workflow](../README.md#local-workflow). Remote-state inputs:
[cloudflare](../cloudflare/README.md).

The Cloudflare state supplies the AdGuard endpoint hostname. The exported
`local_wildcard` feeds Authentik, Proxmox, UniFi, and Uptime Kuma
endpoint construction. Changing this suffix affects DNS and API access
across several roots.

`host_records` exports `home_server`, `photo_server`, `backup_server`, and
`proxmox_server`, each with `hostname` and `ipv4` attributes. Uptime Kuma
uses the backup server hostname/address and Proxmox address. Wildcard
destinations reuse the photo server rewrite answers, and the Home
Assistant client reuses the home server IPv4 answer.

Publish the AdGuard output through a reviewed apply before removing Uptime
Kuma's temporary remote-state defaults. An output-only change still needs
an apply to become visible to consumers. See the
[audit overview](../README.md#reference-and-drift-audit) for verification
and rollout details.

The configuration ignores changes only to `dns.allowed_clients`: the API
reports an unset allowlist as `[]`, while the provider plans `null` and
rejects an explicit
empty list. This also stops detection of future allowlist changes. The
`disallowed_clients` blocklist and other DNS settings remain managed.

### DNS-over-HTTPS and certificate renewal

Traefik manages certificate issuance and renewal for `dns.jstockley.com`.
The exporter in [its Compose stack](../../docker/photo-server/traefik/compose.yml)
reads the ACME store and exports only that domain's `cert.pem` and `key.pem`
to `config/adguard-certs/`. AdGuard mounts this directory read-only at
`/opt/adguardhome/certs`; the provider sends these container paths to the
API rather than copying PEM contents into state. Keep the exported files
and ACME store out of Git and include them in protected host backups.

AdGuard serves native HTTPS on internal port 443, with DoT and DoQ disabled.
Traefik routes `/dns-query` and `/dns-query/<ClientID>` to that HTTPS
listener and verifies its certificate against `dns.jstockley.com`.
The admin UI/API uses internal HTTP port 80 so provisioning remains
reachable before native TLS is enabled; `force_https` must stay false.
Neither internal web port is published on the host. TCP/UDP 53 remains
plain DNS for LAN and VPN clients.

AdGuard's native HTTPS listener allows its DNS Privacy setup guide to
advertise `https://dns.jstockley.com/dns-query` and generate DoH profiles.
Traefik's exporter watches the ACME store for renewals, and AdGuard reloads
certificates supplied by file path automatically. The exporter needs no
Docker socket or network access. Its health check requires a running
watcher, a private key, and a certificate valid for at least seven days.
See the [exporter documentation](https://github.com/kereis/traefik-certs-dumper)
and [AdGuard's encryption guide](https://adguard-dns.io/kb/adguard-home/encryption/).

#### Initial deployment

Deploy the containers before applying the AdGuard TLS settings. The
OpenTofu workflow applies on pushes to `main`, while Compose deployment is
a separate workflow; they do not enforce this ordering automatically.
From the repository root on `photo-server`:

1. Preserve a protected local backup of AdGuard's current YAML and Traefik's
   ACME store. Ensure Traefik's production DNS-challenge credentials exist.
2. Recreate AdGuard with its certificate-directory mount and certificate
   request labels. Its current HTTP listener stays available for the API.
3. Recreate Traefik and start `adguard-cert-exporter`. The dynamic file
   provider must read `/etc/traefik/conf`, including the TLS options.
4. Check the exporter logs and wait for a healthy container. Confirm both
   `config/adguard-certs/cert.pem` and `key.pem` exist; keep the key mode at
   `0600`. Do not paste their contents into logs, Git, or OpenTofu inputs.
5. Configure AdGuard's host-local `dns.trusted_proxies` as described below,
   then review and apply this root's plan. The certificate files must be
   readable at the container paths before enabling TLS through the API.
6. Review and apply the Uptime Kuma plan for the exporter container check,
   which uses the photo server Docker connection and Traefik alert group.
7. Verify the Encryption page and DNS Privacy guide, then test a real DoH
   query and a generated DoH profile. Expect brief DoH unavailability during
   bootstrap, until AdGuard's native HTTPS listener has been enabled.

The relevant host-side commands for steps 2 and 3 are:

```bash
docker compose -f docker/photo-server/adguard/compose.yml up -d
docker compose -f docker/photo-server/traefik/compose.yml up -d
docker compose -f docker/photo-server/traefik/compose.yml logs --tail=50 adguard-cert-exporter
docker inspect adguard-cert-exporter --format '{{.State.Health.Status}}'
```

#### Proxy identity and validation

The provider cannot manage `dns.trusted_proxies`. Merge this list into the
existing `dns` object in `docker/photo-server/adguard/conf/AdGuardHome.yaml`
on the host, replacing placeholders with Traefik's actual addresses on the
`proxy` network and omitting IPv6 if none is assigned:

```yaml
dns:
  trusted_proxies:
    - 127.0.0.0/8
    - ::1/128
    - TRAEFIK_PROXY_IPV4/32
    - TRAEFIK_PROXY_IPV6/128
```

Inspect those addresses from the host:

```bash
docker inspect traefik --format '{{json (index .NetworkSettings.Networks "proxy")}}'
```

Stop AdGuard before editing its YAML, preserve other settings, and restart
it afterwards. Refresh the list if Traefik's addresses change on recreation,
or reserve stable addresses after inspecting the network's IPAM settings.
Trust only the proxy addresses rather than the entire shared subnet.
DoH now uses native HTTPS, so `http.doh.insecure_enabled` is unnecessary;
keep it false if it was previously enabled. See AdGuard's
[configuration reference](https://adguard-dns.io/kb/adguard-home/configuration/).

From a client, validate DoH after rollout (the query asks for `example.com A`):

```bash
curl --fail-with-body --dump-header - \
  --header 'Accept: application/dns-message' \
  'https://dns.jstockley.com/dns-query?dns=AAABAAABAAAAAAAAB2V4YW1wbGUDY29tAAABAAE' \
  --output /tmp/adguard-doh-response.bin
```

Expect HTTP 200 with `Content-Type: application/dns-message`, a valid DNS
answer, and the expected client address in AdGuard's query log. Also check
`/dns-query/<ClientID>` and that HTTP redirects to HTTPS. Do not bypass
certificate verification. Inspect Traefik logs for upstream TLS errors.
The Cloudflare-proxied DNS record is retained; use
[Full (strict) SSL/TLS mode](https://developers.cloudflare.com/ssl/origin-configuration/ssl-modes/full-strict/)
for the Cloudflare-to-Traefik connection. Forwarded-header trust must match
actual upstream proxies; direct-origin requests must not be able to forge
Cloudflare client-IP headers.

For recovery, restore a valid matching certificate/key pair to the exported
directory and let AdGuard reload it. If native TLS cannot start, use the
admin/API route to disable TLS temporarily and restore the previous proxy
route while investigating. Disabling native TLS does not disable plain DNS
on port 53. Stop the exporter before restoring files it would overwrite.

Check DNS resolution from a client using this server after an authorized
change. Review wildcard IPv4/IPv6 destinations and individual rewrites
together when moving hosts. The Compose stack's `wg` addresses also matter
for VPN DNS; rewrites alone do not configure the VPN network.

## Validation and maintenance

From this directory, after backend and credential provisioning:

```bash
bash ../init.sh
tofu validate
tofu plan -out=tfplan
```

Review the plan before an authorized apply. Follow the
[shared workflow and CI caveats](../README.md) for state access and rollout.

**Maintenance:** review this README with every change in this directory.
Update the resource map, inputs, dependencies, operational notes, and any
affected state consumers or overview diagram in the same change. Follow
[the required documentation checklist](../../docs/documentation.md).

# Cloudflare

[OpenTofu overview](../README.md)

Manages public DNS, dynamically discovered host addresses, Cloudflare
Tunnel configuration, and Zero Trust applications and access policies.

## Configuration map

| File | Responsibility |
| --- | --- |
| [provider.tofu](provider.tofu) | Provider requirements, HTTP backend, inputs, and API configuration. |
| [dns-records.tofu](dns-records.tofu) | DNS records and hostname outputs used by other roots. |
| [dynamic_ips.tofu](dynamic_ips.tofu) | HTTP lookups for Racknerd, Iowa, and Chicago addresses. |
| [tunnels.tofu](tunnels.tofu) | Tunnel resources and origin/ingress configuration. |
| [zero_trust.tofu](zero_trust.tofu) | Access applications, policies, and an identity provider. |

Provider sources: `cloudflare/cloudflare`, `hashicorp/http`. See
`provider.tofu` for version constraints and `.terraform.lock.hcl` for
selected dependency versions.

## Inputs and dependencies

Declared inputs, supplied as `TF_VAR_<name>` or approved local inputs:

- `cloudflare_api_token`
- `cloudflare_zone_id`
- `cloudflare_account_id`
- `gitlab_username`
- `gitlab_access_token`
- `jstockley_api_key`

Also supply the backend variables described in the
[shared local workflow](../README.md#local-workflow). Remote-state inputs:
[authentik](../authentik/README.md).

Reads Authentik OAuth outputs for the identity provider; Authentik reads
Cloudflare hostnames in return. This cycle requires existing outputs or a
separate bootstrap procedure. Address lookups use the custom API and its
API key, so a plan also depends on that API being reachable.

DNS outputs are consumed by AdGuard, Authentik, Better Stack, Forgejo,
Infisical, and Uptime Kuma. Review those consumers when renaming
or removing outputs. Tunnel configuration here must agree with the
[connector stack](../../docker/racknerd/cloudflared/compose.yml) and its
host-local credentials.

The SimpleLogin MX and TXT records reuse the managed mail A record's name.
The dynamic-address API base URL remains explicit: deriving it from the
API DNS record would create a cycle through the VPN address lookup. The
[October 2026 audit](../README.md#reference-and-drift-audit) records
existing DNS-comment and Access-policy differences that a full plan can
include alongside otherwise unchanged mail records.

## API token permissions

The previous guide lists these permissions; scope the token to the actual
account and zone and review its needs when resource types change.

| Use | Permissions recorded in this repository |
| --- | --- |
| DNS records | `Zone.Zone:Edit`, `Zone.DNS:Edit` |
| Zero Trust Access | `Account.Access: Apps and Policies:Edit`, `Zone.DNS:Edit` |
| Identity providers | `Account.Access: Organizations, Identity Providers, and Groups:Edit` |

These notes are not an exhaustive permission list for tunnel resources.
Validate required API access during planning. After an authorized rollout,
check DNS answers, tunnel health, and the affected access/sign-in flow.

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

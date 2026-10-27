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
| [dns-rewrites.tofu](dns-rewrites.tofu) | Internal host records and local wildcard rewrites; exports `local_wildcard` without the wildcard prefix. |
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
`local_wildcard` feeds Authentik, Proxmox, UniFi, Uptime Kuma, and Databasus
endpoint construction. Changing this suffix affects DNS and API access
across several roots.

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

# Uptime Kuma

[OpenTofu overview](../README.md)

Manages two monitoring instances through `local` and `public` provider
aliases. Their applications run on the photo server and Racknerd; this
root configures monitoring after those instances exist.

## Configuration map

| File | Responsibility |
| --- | --- |
| [provider.tofu](provider.tofu) | Provider requirements, HTTP backend, inputs, and API configuration. |
| [local_monitors.tofu](local_monitors.tofu) | Local Docker, HTTP, content/JSON, and ping checks. |
| [public_monitors.tofu](public_monitors.tofu) | Public instance monitor definitions. |
| [local_groups.tofu](local_groups.tofu) | Local monitor groups. |
| [public_groups.tofu](public_groups.tofu) | Public monitor groups. |
| [local_docker_host.tofu](local_docker_host.tofu) | Local Docker host connection. |
| [public_docker_host.tofu](public_docker_host.tofu) | Public Docker host connection. |
| [local_notifications.tofu](local_notifications.tofu) | Local SMTP and Nextcloud Talk notifications. |
| [public_notifications.tofu](public_notifications.tofu) | Public SMTP and Nextcloud Talk notifications. |
| [local_maintenances.tofu](local_maintenances.tofu) | Local maintenance schedules and monitor associations. |
| [public_maintenances.tofu](public_maintenances.tofu) | Public maintenance schedules and monitor associations. |
| [local_tags.tofu](local_tags.tofu) | Local monitor tags. |

Provider sources: `breml/uptimekuma`. See
`provider.tofu` for version constraints and `.terraform.lock.hcl` for
selected dependency versions.

## Inputs and dependencies

Declared inputs, supplied as `TF_VAR_<name>` or approved local inputs:

- `smtp_password`
- `gitlab_username`
- `gitlab_access_token`
- `uptime_kuma_local_username`
- `uptime_kuma_public_username`
- `uptime_kuma_local_password`
- `uptime_kuma_public_password`
- `nextcloud_talk_conversation_token`
- `nextcloud_talk_local_secret`
- `nextcloud_talk_public_secret`

Also supply the backend variables described in the
[shared local workflow](../README.md#local-workflow). Remote-state inputs:
[cloudflare](../cloudflare/README.md), [adguard](../adguard/README.md),
[better-stack](../better-stack/README.md).

Cloudflare supplies public hostnames; AdGuard supplies the local suffix.
Better Stack supplies the local heartbeat URL. Each instance has separate
credentials and Nextcloud Talk secrets; SMTP and conversation inputs are
also required. Keep provider aliases explicit when adding resources.

When a service is renamed or removed, review both monitor files, groups,
notification associations, maintenance links, Docker container names, and
any JSON/content assertions. Monitoring includes endpoints whose deployment
is outside this repository; a monitor is not evidence of a Compose stack.
After an authorized change, check actual probe results and alert delivery.
CI establishes WireGuard for local instance access.

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

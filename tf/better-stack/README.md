# Better Stack

[OpenTofu overview](../README.md)

Manages external monitoring of services that should remain observable
outside the Docker hosts. Uses the `betteruptime` provider.

## Configuration map

| File | Responsibility |
| --- | --- |
| [provider.tofu](provider.tofu) | Provider requirements, HTTP backend, inputs, and API configuration. |
| [monitors.tofu](monitors.tofu) | Public Uptime Kuma and AdGuard HTTP checks plus a heartbeat for the local monitor. |

Provider sources: `BetterStackHQ/better-uptime`. See
`provider.tofu` for version constraints and `.terraform.lock.hcl` for
selected dependency versions.

## Inputs and dependencies

Declared inputs, supplied as `TF_VAR_<name>` or approved local inputs:

- `gitlab_username`
- `gitlab_access_token`
- `better_stack_api_key`

Also supply the backend variables described in the
[shared local workflow](../README.md#local-workflow). Remote-state inputs:
[cloudflare](../cloudflare/README.md).

Reads public hostnames from Cloudflare state. Exports
`uptime-kuma-local-monitor-heartbeat-url`, consumed by the local Uptime
Kuma monitor configuration. The heartbeat period is 300 seconds with a
60-second grace period; keep its caller's cadence compatible.

Review expected HTTP codes and alert delivery when changing targets.
After an authorized change, verify both ordinary probes and the local
heartbeat path; a public HTTP check does not prove the heartbeat is sent.

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

# Databasus

[OpenTofu overview](../README.md)

Defines backup configuration through the Databasus API. Databasus runs
alongside PostgreSQL on both Docker hosts; this root currently enables
resources only for the local instance.

## Configuration map

| File | Responsibility |
| --- | --- |
| [provider.tofu](provider.tofu) | Provider requirements, HTTP backend, inputs, and API configuration. |
| [workspace.tofu](workspace.tofu) | Local workspace; public workspace block is commented out. |
| [storage.tofu](storage.tofu) | Local storage linked to the local workspace; public block is commented out. |
| [webhook.tofu](webhook.tofu) | Local webhook notifier to the custom API; public block is commented out. |

Provider sources: `pkerspe/databasus`. See
`provider.tofu` for version constraints and `.terraform.lock.hcl` for
selected dependency versions.

## Inputs and dependencies

Declared inputs, supplied as `TF_VAR_<name>` or approved local inputs:

- `gitlab_username`
- `gitlab_access_token`
- `databasus_public_password`
- `databasus_local_password`
- `jstockley_api_key`

Also supply the backend variables described in the
[shared local workflow](../README.md#local-workflow). Remote-state inputs:
[cloudflare](../cloudflare/README.md), [adguard](../adguard/README.md).

The provider declares `local` and `public` aliases. Cloudflare and AdGuard
state supply the public hostname and local suffix respectively. Both
password inputs are declared without defaults even though public resource
blocks are commented out; do not assume public input/setup is unnecessary
without inspecting the actual plan.

The webhook uses `jstockley_api_key` for authentication. The configuration
does not define database backup jobs or a complete restore policy. Check
[the host verification service](../../services/README.md) for the separate
agent unit; managing a notifier does not install that binary.

This root has no job in `tf-state.yml`, and the checked-in Infisical
OpenTofu environment/OIDC configuration does not include Databasus.
Plan and apply through an explicit authorized local process until that
coverage is implemented. Verify workspace storage and a test notification
after an authorized change.

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

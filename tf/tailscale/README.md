# Tailscale

[OpenTofu overview](../README.md)

Manages the tailnet policy and tags for the Arcane manager and agent.
This root has an HTTP backend but no remote-state inputs from other roots.

## Configuration map

| File | Responsibility |
| --- | --- |
| [provider.tofu](provider.tofu) | Provider requirements, HTTP backend, inputs, and API configuration. |
| [acl.tofu](acl.tofu) | Tailnet grants and tag ownership policy encoded as JSON. |
| [devices.tofu](devices.tofu) | Lookups of the existing manager and agent devices by name. |
| [tags.tofu](tags.tofu) | Tag assignments to the looked-up devices. |

Provider sources: `tailscale/tailscale`. See
`provider.tofu` for version constraints and `.terraform.lock.hcl` for
selected dependency versions.

## Inputs and dependencies

Declared inputs, supplied as `TF_VAR_<name>` or approved local inputs:

- `oauth_client_id`
- `oauth_client_secret`

Also supply the backend variables described in the
[shared local workflow](../README.md#local-workflow). This root reads no other
root state.

The Arcane agent is allowed to reach the manager on TCP 3552. Device names
must match the Tailscale sidecars in the
[photo server manager](../../docker/photo-server/arcane/compose.yml) and
[Racknerd agent](../../docker/racknerd/arcane-agent/compose.yml) stacks.
OAuth credentials need access to the tailnet policy and device tags.

The CI path filter currently spells the directory `tf/tailcale/**`.
A change confined to this root can therefore skip its job. Confirm that a
plan actually ran, or run the documented local workflow. After an
authorized change, verify both manager connectivity and the intended
restriction on agent access.

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

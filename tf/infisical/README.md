# Infisical

[OpenTofu overview](../README.md)

Manages the secret manager's projects, environments, machine identities,
GitHub OIDC authentication bindings, and project identity roles. The
application itself runs in
[the photo server stack](../../docker/photo-server/infisical/compose.yml).

## Configuration map

| File | Responsibility |
| --- | --- |
| [provider.tofu](provider.tofu) | Provider requirements, HTTP backend, inputs, and API configuration. |
| [projects.tofu](projects.tofu) | Projects and environments, including infrastructure host/security environments and OpenTofu provider environments. |
| [identities.tofu](identities.tofu) | Machine identities, OIDC issuer/audience/subject restrictions, and project access roles. |

Provider sources: `Infisical/infisical`. See
`provider.tofu` for version constraints and `.terraform.lock.hcl` for
selected dependency versions.

## Inputs and dependencies

Declared inputs, supplied as `TF_VAR_<name>` or approved local inputs:

- `gitlab_username`
- `gitlab_access_token`
- `infisical_client_id`
- `infisical_client_secret`

Also supply the backend variables described in the
[shared local workflow](../README.md#local-workflow). Remote-state inputs:
[cloudflare](../cloudflare/README.md).

Reads the secret service hostname from Cloudflare state. Provider access
uses an existing Infisical client ID and client secret. This root manages
access configuration, not all secret values. Running CI requires the
secret service and its bootstrap credentials to exist first.

GitHub job `environment` names must match OIDC subject restrictions and
Infisical environment slugs. Review workflow permissions, audience,
identity ID, project slug, and role together when adding an environment.
Databasus is currently absent from the OpenTofu environment and subject
lists. Avoid removing the active identity or credentials needed to manage
this root without a separate recovery path.

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

# Authentik

[OpenTofu overview](../README.md)

Manages identity configuration for self-hosted applications. The identity
server and worker run in
[the photo server stack](../../docker/photo-server/authentik/compose.yml).

## Configuration map

| File | Responsibility |
| --- | --- |
| [provider.tofu](provider.tofu) | Provider requirements, HTTP backend, inputs, and API configuration. |
| [users.tofu](users.tofu) | Managed user accounts. |
| [groups.tofu](groups.tofu) | Managed identity groups. |
| [defaults.tofu](defaults.tofu) | Read-only lookups for provider authorization/invalidation flows, standard OAuth scopes, and the existing signing certificate. |
| [applications.tofu](applications.tofu) | Applications, OAuth2 and proxy providers, policy bindings, scope mappings, and exported client settings. |
| [outpout.tofu](outpout.tofu) | Outpost definition; the filename is intentionally shown as it exists. |

Provider sources: `goauthentik/authentik`. See
`provider.tofu` for version constraints and `.terraform.lock.hcl` for
selected dependency versions.

## Inputs and dependencies

Declared inputs, supplied as `TF_VAR_<name>` or approved local inputs:

- `authentik_api_token`
- `gitlab_username`
- `gitlab_access_token`

Also supply the backend variables described in the
[shared local workflow](../README.md#local-workflow). Remote-state inputs:
[cloudflare](../cloudflare/README.md), [adguard](../adguard/README.md).

Cloudflare state provides public hostnames; AdGuard provides the local DNS
suffix. OAuth outputs are consumed by Cloudflare, creating a remote-state
cycle. Client secrets are sensitive outputs and must remain outside prose
and logs.

Review redirect URIs, provider URLs, policy bindings, and the corresponding
Traefik routes together. Verify an affected sign-in flow after an
authorized change. Updating a provider in OpenTofu does not automatically
refresh host-local `.env` values used by application containers.

Provider defaults are selected by flow slug, scope managed name, and
certificate name instead of installation-specific UUIDs. Certificate and
private-key retrieval are disabled for the signing-key lookup; only its
ID is needed. Custom mappings such as the Beszel email scope remain
managed resources. wg-easy callback URLs use the AdGuard local suffix.

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

# Forgejo

[OpenTofu overview](../README.md)

Manages Forgejo user accounts and repository mirrors. The service runs in
[the photo server stack](../../docker/photo-server/forgejo/compose.yml).

## Configuration map

| File | Responsibility |
| --- | --- |
| [provider.tofu](provider.tofu) | Provider requirements, HTTP backend, inputs, and API configuration. |
| [users.tofu](users.tofu) | User account configuration. |
| [repos.tofu](repos.tofu) | Repository mirrors, owners, source URLs, visibility, branches, and synchronization intervals. |

Provider sources: `svalabs/forgejo`. See
`provider.tofu` for version constraints and `.terraform.lock.hcl` for
selected dependency versions.

## Inputs and dependencies

Declared inputs, supplied as `TF_VAR_<name>` or approved local inputs:

- `gitlab_username`
- `gitlab_access_token`
- `forgejo_token`
- `github_token`
- `research_git_token`
- `forgejo_password`

Also supply the backend variables described in the
[shared local workflow](../README.md#local-workflow). Remote-state inputs:
[cloudflare](../cloudflare/README.md).

Reads the Forgejo hostname from Cloudflare state. Input tokens authenticate
the Forgejo API and upstream Git sources. Protect mirror credentials and
review repository visibility before applying a change.

When adding a mirror, check its source URL, owner, default branch,
visibility, and synchronization behavior. After an authorized rollout,
confirm the repository exists and its first synchronization succeeds;
a successful API plan alone does not prove the upstream token can clone.

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

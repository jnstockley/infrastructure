# Repository Guidelines

## Documentation scope

Keep Markdown focused on general architecture, setup, dependencies,
validation, deployment, and recovery guidance. Do not update Markdown for
every code or configuration change, or append per-change summaries,
monitor details, audit results, plan counts, or task history to READMEs.
Keep implementation details in the configuration and report change-specific
validation in the handoff or PR.

Update documentation only when a change makes existing guidance inaccurate
or introduces a major section that needs an overview. When an update is
needed, include it in the same change and check relevant links and diagrams.
Do not make documentation edits solely to record that a change happened,
and do not require a list of reviewed documents in every handoff.

See [docs/documentation.md](docs/documentation.md) for scope and conventions.
Never copy secrets into documentation.

## New or changed Docker services

When adding a Compose stack or adding/renaming services, implement the
applicable monitoring and identity integrations in the same change:

- Add Uptime Kuma container checks for every long-running container,
  including workers and sidecars, using the correct host's Docker connection.
- Add an HTTP check for each applicable web service. Prefer a JSON health
  endpoint with an explicit healthy-value assertion, then a keyword health
  check, then an HTTP status check or index-page check if no health endpoint
  exists. Verify endpoint support for the deployed application version.
- Check whether the application supports OIDC login through Authentik.
  When supported and usable, add the provider, application, access policy
  bindings, and application-side configuration. Check plugin/licensing and
  secret requirements; respect explicit user deferrals.
- Follow the [stack integration checklist](docker/README.md#stack-integration-checklist)
  for groups, alerts, validation, exceptions, and completion criteria. If an
  integration is blocked or inapplicable, explain why in the handoff;
  do not silently omit it or claim it is configured.

These are configuration requirements, not a requirement to edit Markdown
for every new monitor or application.

## Project Structure & Module Organization

`docker/` contains deployable Docker Compose stacks grouped by host
(`photo-server/`, `racknerd/`, `synology/`), usually one service per
directory with a `compose.yml` and occasional `sample.env`. `tf/` holds
Terraform environment inputs and related notes; keep provider-specific
files inside their existing subdirectories. `scripts/` contains CI and ops
helpers such as `diffs.sh` and `lint.sh`. `tests/` contains the Python
compatibility checks for Compose images. `services/` holds host systemd
units, `docs/` indexes runbooks, and `trivy/` contains security scan
configuration. `.github/` contains workflow
and dependency-update configuration. There is currently no `nix/` tree,
although CI retains a Nix path filter and lint job.

## Build, Test, and Development Commands

Use Python 3.14 with `uv`.

- `uv sync` installs the local Python tooling from `pyproject.toml`.
- `bash scripts/lint.sh` runs the main local lint suite: `yamllint`,
  `dclint`, `shellcheck`, `shfmt`, and `ruff`.
- `FILES=docker/racknerd/api/compose.yml uv run pytest
  tests/test_containers.py` validates that the image referenced by a
  changed Compose file can start with `testcontainers`.
- `docker compose -f docker/photo-server/immich/compose.yml config` checks
  Compose syntax before opening a PR.

## Coding Style & Naming Conventions

Shell scripts should remain POSIX-friendly where practical and are
formatted with `shfmt -i 4 -ci`; use 4-space indentation in shell, YAML,
and Nix files to match the repo. Python follows `ruff check` and
`ruff format`. Keep Compose files named `compose.yml`, Terraform variable
files named `terraform.tfvars`, and group service definitions under the
appropriate host directory. Prefer lowercase, hyphenated directory names
such as `uptime-kuma` and `photo-server`.

## Testing Guidelines

Add or update tests when changing deployment logic, image selection, or
validation scripts. The current pytest suite reads changed files from the
`FILES` environment variable, so pass a comma-separated list when testing
multiple Compose stacks. Keep test files under `tests/` and name them
`test_*.py`.

## Commit & Pull Request Guidelines

Recent history uses short, imperative subjects such as `Add concurrency`
or `Only run docker scan on file changes`. Follow that pattern and keep
one logical change per commit. PRs should describe the affected host or
Terraform area, list validation performed (`bash scripts/lint.sh`,
targeted pytest run, manual `docker compose ... config`), and include
screenshots only when UI-facing services are changed.

## Security & Configuration Tips

Do not commit live secrets or generated `.env` files; use the existing
`sample.env` pattern and Infisical-backed CI secrets. Treat
`terraform.tfvars` as environment-specific inputs and review Trivy
findings before merging.

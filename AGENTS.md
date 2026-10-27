# Repository Guidelines

## Required Documentation Review — Every Change

**A task is not complete until documentation has been reviewed and any
needed updates are included in the same change.** This requirement applies
to every AI agent working anywhere in this repository, including automated
dependency changes and follow-up edits. Do not defer documentation to a
separate task or PR.

Before editing, read the nearest section/host/provider `README.md` and
[docs/documentation.md](docs/documentation.md). Before reporting completion:

1. Review the docs for every changed area, including relevant parent
   overviews, runbooks, inventories, examples, and Mermaid diagrams.
2. Update all descriptions affected by added, changed, moved, or removed
   configuration. Check dependencies, input names, networking, storage,
   deployment, validation, and recovery steps where applicable.
3. Add a linked README for every new major section, Docker host, or
   OpenTofu root. Update indexes and links when moving or removing one.
4. Check Markdown formatting, relative links, and diagram relationships
   against the final implementation. Never copy secret values into docs.
5. In the final handoff or PR, list documentation updated and validation
   performed. If no documentation edit is needed, explicitly name the
   documents reviewed and explain why they remain accurate.

Use the change-to-document mapping and completion checklist in
[docs/documentation.md](docs/documentation.md). A passing code test or lint
job does not replace this required review.

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

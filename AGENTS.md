# Repository Guidelines

## Project Structure & Module Organization
`docker/` contains deployable Docker Compose stacks grouped by host (`photo-server/`, `racknerd/`, `synology/`), usually one service per directory with a `compose.yml` and occasional `.env.example`. `tf/` holds Terraform environment inputs and related notes; keep provider-specific files inside their existing subdirectories. `scripts/` contains CI and ops helpers such as `diffs.sh` and `lint.sh`. `tests/` contains the Python compatibility checks for Compose images. `nix/` stores machine-specific Nix configurations, and `trivy/` contains security scan configuration.

## Build, Test, and Development Commands
Use Python 3.14 with `uv`.

- `uv sync` installs the local Python tooling from `pyproject.toml`.
- `bash scripts/lint.sh` runs the main local lint suite: `yamllint`, `dclint`, `shellcheck`, `shfmt`, and `ruff`.
- `FILES=docker/racknerd/api/compose.yml uv run pytest tests/test_containers.py` validates that the image referenced by a changed Compose file can start with `testcontainers`.
- `docker compose -f docker/photo-server/immich/compose.yml config` checks Compose syntax before opening a PR.

## Coding Style & Naming Conventions
Shell scripts should remain POSIX-friendly where practical and are formatted with `shfmt -i 4 -ci`; use 4-space indentation in shell, YAML, and Nix files to match the repo. Python follows `ruff check` and `ruff format`. Keep Compose files named `compose.yml`, Terraform variable files named `terraform.tfvars`, and group service definitions under the appropriate host directory. Prefer lowercase, hyphenated directory names such as `uptime-kuma` and `photo-server`.

## Testing Guidelines
Add or update tests when changing deployment logic, image selection, or validation scripts. The current pytest suite reads changed files from the `FILES` environment variable, so pass a comma-separated list when testing multiple Compose stacks. Keep test files under `tests/` and name them `test_*.py`.

## Commit & Pull Request Guidelines
Recent history uses short, imperative subjects such as `Add concurrency` or `Only run docker scan on file changes`. Follow that pattern and keep one logical change per commit. PRs should describe the affected host or Terraform area, list validation performed (`bash scripts/lint.sh`, targeted pytest run, manual `docker compose ... config`), and include screenshots only when UI-facing services are changed.

## Security & Configuration Tips
Do not commit live secrets or generated `.env` files; use the existing `.env.example` pattern and Infisical-backed CI secrets. Treat `terraform.tfvars` as environment-specific inputs and review Trivy findings before merging.

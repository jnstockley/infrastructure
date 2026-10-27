# Security scanning

[Repository overview](../README.md) · [Automation guide](../.github/README.md)

Trivy scans repository files, container images, and selected Linux hosts.
GitHub Actions uploads SARIF reports to the repository's Security view.
The scan definitions and explicit command-line flags determine coverage;
a successful job alone does not mean there are no findings.

## Scan surfaces

| Surface | Configuration | Execution and output |
| --- | --- | --- |
| Repository filesystem | [trivy.yaml](trivy.yaml), [trivy-scan.yml](../.github/workflows/trivy-scan.yml) | Dependencies, secrets, and misconfiguration; filesystem SARIF |
| Container images | Image extraction and scan loop in `trivy-scan.yml` | Unique static `image:` references under `docker/`; merged image SARIF |
| OpenTofu/IaC | Terraform job in `trivy-scan.yml` | Configuration scan of `tf/`; separate IaC SARIF category |
| Host filesystem | [compose.yml](compose.yml), [trivy-host-scan.yml](../.github/workflows/trivy-host-scan.yml) | Racknerd and photo server root filesystem; retrieved and tagged SARIF |

Repository/image workflows run on PRs and pushes to `main`, Mondays at
06:00 UTC, and manual dispatch. The image job additionally requires a
Docker path change unless the event is scheduled/manual. Host scans run
Mondays at 07:00 UTC or manually; Synology is not included.

## Filters and limits

[trivy.yaml](trivy.yaml) enables vulnerability, secret, and misconfiguration
scanners and excludes `.git`, `.github`, virtual environments, Python
caches, `node_modules`, `.cache`, `docs`, and `tests`. Vulnerability settings
ignore unfixed issues and select high/critical severity. Misconfiguration
settings list all severities, while workflow invocations explicitly request
high/critical. Review both sources when assessing what a run reports.

Image extraction scans static image references and skips leading variable
expressions. Images supplied only by runtime interpolation are not covered
by that extraction. The image loop uses `--exit-code 0`, so findings appear
in reports without failing that step solely because vulnerabilities exist.
Registry credentials come from Infisical and GitHub authentication.

Host Compose scanning mounts `/` read-only at `/app` and this directory
writable at `/report`. It scans vulnerabilities/misconfiguration, skips
`var/lib/docker/`, `run/`, and `tmp/`, requests high/critical severity, and
ignores unfixed vulnerabilities. It does not load `trivy.yaml` explicitly
and does not enable the secret scanner in its command. The output is
`trivy-results.sarif` in this directory; CI copies and deletes that remote
report, tags results, and uploads it.

## Run the host scan deliberately

Run from `trivy/` on the intended Linux host with Docker and filesystem
access available:

```bash
docker compose config --quiet
docker compose run --rm trivy
```

This scans the host, not just the repository, and writes a report. Review
results before sharing them because paths and findings can describe host
configuration. The [KICS helper](../scripts/security.sh) is a separate
repository scan with its own exclusions.

Review actionable findings before merging; distinguish remediation,
accepted exceptions, and scan failures. Changing an exclusion changes
coverage and must be documented with its reason.

**Maintenance:** update this scope map, schedules, flags, exclusions, report
paths, and automation links with every relevant change. Follow
[the required checklist](../docs/documentation.md).

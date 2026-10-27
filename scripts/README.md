# Operations and validation scripts

[Repository overview](../README.md) · [Automation](../.github/README.md)

These helpers are Bash scripts. Run repository checks from the repository
root; remote/system helpers act on the machine or host named by their
arguments. Read each script before using an operational command.

## Script map

| Script | Inputs and prerequisites | Behavior |
| --- | --- | --- |
| [lint.sh](lint.sh) | `yamllint`, Node/`npx`, `shellcheck`, `shfmt`, `uvx`, and `tofu` on PATH | Checks YAML, Compose, shell, Python, and OpenTofu formatting |
| [diffs.sh](diffs.sh) | Base branch, merged branch, folder pattern; Git history, network, `GITHUB_OUTPUT` | Fetches Git refs, finds a merge, selects matching Compose paths, writes CSV output |
| [diffs-no-merge.sh](diffs-no-merge.sh) | Base branch, head branch, folder pattern; Git refs, network, `GITHUB_OUTPUT` | Compares branch tips and emits matching Compose paths as CSV |
| [security.sh](security.sh) | Docker daemon and registry/network access | Pulls KICS and scans this checkout with explicit excluded query IDs; writes reports here |
| [ssh.sh](ssh.sh) | `-u` user, `-k` key contents, `-h` host, `-c` commands; SSH and Expect | Creates temporary key/config/command files and executes remote commands |
| [system-update.sh](system-update.sh) | Root/sudo on Debian/Ubuntu with `apt-get` | Updates package metadata, upgrades packages/distribution dependencies, autoremoves, and cleans |

`ssh.sh` writes the `-k` argument as key content despite usage text also
mentioning a key path. It disables SSH host key verification, supplies an
empty passphrase to Expect, and cleans temporary files at the end of the
successful path. Current deploy workflows use the SSH action directly;
this helper is not their deployment implementation.

## Local validation

```bash
bash scripts/lint.sh
```

The script runs several checks sequentially without `set -e` or an
aggregate failure status. Inspect all output: the final command's status
alone does not establish that every preceding check passed. The CI lint
workflow runs checks in separate jobs and additionally checks Markdown.

Use [the testing guide](../tests/README.md) for image startup checks and
[the OpenTofu guide](../tf/README.md) for API planning. Do not run
`system-update.sh` as part of local linting; it changes OS packages.
`security.sh` is a scan helper and does not replace the
[Trivy workflows](../trivy/README.md).

## Change detection helpers

Both diff helpers require three positional arguments and export
`changed_files` through `GITHUB_OUTPUT`. Their folder argument is used in
an extended regular expression; the compatibility workflow passes
`docker/racknerd|docker/photo-server` to select both hosts. Match behavior
is defined by the script's regex and should be verified when changing it.
They only select `compose.yml`, not arbitrary changed config or scripts.

`diffs.sh` depends on merge commits and commit message matching.
`diffs-no-merge.sh` compares branch tips rather than a merge-base diff.
Deleted paths can be returned too; selection is not a guarantee that a
file still exists or can be deployed.

## Related helpers outside this directory

- [OpenTofu initialization](../tf/init.sh) and
  [installer](../tf/install.sh)
- [Photo server PostgreSQL backup](../docker/photo-server/postgres/backup.sh)
- [Photo server monitoring backup](../docker/photo-server/uptime-kuma/backup.sh)
  and [Racknerd monitoring backup](../docker/racknerd/uptime-kuma/backup.sh)
- [AdGuard restart](../docker/photo-server/adguard/restart.sh)
- [Immich cleanup](../docker/photo-server/immich/untracked_cleanup.py)

These scripts may modify services or data. Their existence does not mean
that CI or a host scheduler runs them.

**Maintenance:** update arguments, prerequisites, side effects, callers,
and linked guides whenever a script changes. Add or update meaningful
tests for deployment/validation logic, following
[the repository rules](../AGENTS.md)
and [the documentation checklist](../docs/documentation.md).

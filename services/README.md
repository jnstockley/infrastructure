# Host systemd services

[Repository overview](../README.md)

This directory holds host-native service units that are separate from
Docker Compose projects. It currently contains
[databasus-verification-agent.service](databasus-verification-agent.service).

## Databasus verification agent

The unit runs as `jackstockley:jackstockley` from `/home/jackstockley`.
After the network-online target, `ExecStartPre` repeatedly checks
`https://databasus.jstockley.com` with `curl -sf` every two seconds. When
that endpoint responds successfully, systemd runs
`/home/jackstockley/verification-agent start`.

It uses `Type=oneshot` and `RemainAfterExit=yes`. An active unit can mean
the start command completed; it does not by itself establish that the
agent is continuously running or that backup verification succeeds. The
pre-start loop has no explicit attempt limit in the unit and is subject
to the host's systemd startup timeout behavior.

## Prerequisites and installation

The target Linux host needs systemd, Bash, curl, working network/DNS access,
the specified user/group and home directory, and a separately provisioned
verification-agent executable and its required configuration. The binary
and its registration/bootstrap procedure are not supplied by this repo.
The unit alone does not identify a deployment host or install credentials.

After provisioning those prerequisites and authorizing installation, run
from the repository root on the target host:

```bash
systemd-analyze verify services/databasus-verification-agent.service
sudo install -m 0644 services/databasus-verification-agent.service /etc/systemd/system/databasus-verification-agent.service
sudo systemctl daemon-reload
sudo systemctl enable --now databasus-verification-agent.service
systemctl status databasus-verification-agent.service
journalctl -u databasus-verification-agent.service --no-pager -n 100
```

These installation commands change host configuration. For an installed
unit update, reload systemd and restart it deliberately; inspect logs and
Databasus verification results afterward. To stop automatic startup,
disable and stop the unit through systemd as part of the authorized
rollback. This does not remove the external binary or its registration.

## Related configuration

Databasus containers are in the
[photo server](../docker/photo-server/postgres/compose.yml)
and [Racknerd](../docker/racknerd/postgres/compose.yml) PostgreSQL stacks.
[OpenTofu Databasus](../tf/databasus/README.md) manages local workspace,
storage, and notification settings; it does not deploy this service.
The existing Docker deployment workflow does not install systemd units.

**Maintenance:** review this guide whenever a unit changes. Update binary
paths, user/group, startup behavior, endpoint dependencies, installation,
and verification instructions in the same change, following
[the documentation checklist](../docs/documentation.md).

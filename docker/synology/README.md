# Synology

[Docker overview](../README.md) · [Repository overview](../../README.md)

This directory currently contains one stack:
[Beszel agent](beszel/compose.yml). It sends NAS monitoring information to
the Beszel hub configured at `https://stats.local.jstockley.com`.

## Runtime requirements

The agent reads the Docker socket through a read-only mount, loads `.env`,
and publishes TCP 45876 on all IPv4 interfaces. The configured UID/GID are
1026/100. Verify the NAS socket location, permissions, DNS resolution of
the hub, and intended firewall access to the agent port.

Use [sample.env](beszel/sample.env) as the starting point for the required
host-local environment file. Populate authentication values through the
approved secret provisioning process; do not commit them.

## Validate and deploy

Run from the repository root on the NAS with Docker Compose available:

```bash
docker compose -f docker/synology/beszel/compose.yml config --quiet
docker compose -f docker/synology/beszel/compose.yml up -d
docker compose -f docker/synology/beszel/compose.yml ps
```

The `up` command changes the running service. After deployment, check the
agent healthcheck and confirm the NAS appears in the photo server's Beszel
hub. Compose health alone does not confirm successful hub registration.

Synology is outside the current deploy workflow and pytest path allowlist.
The repository's image scanning extracts references across `docker/`,
including this stack. See [automation coverage](../../.github/README.md).

**Maintenance:** update this guide and the Docker host index whenever a
Synology stack, mount, environment requirement, port, or deployment process
changes. Follow [the checklist](../../docs/documentation.md).

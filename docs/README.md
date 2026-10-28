# Operations documentation

[Repository overview](../README.md)

Use area READMEs for architecture and routine changes. Use the runbooks
below for detailed setup and troubleshooting. Existing runbooks may contain
older commands or assumptions; compare them with the current configuration
before applying them to a host.

## Guides and runbooks

| Document | Purpose |
| --- | --- |
| [Documentation maintenance](documentation.md) | Documentation scope and writing conventions |
| [UPS notes](ups.md) | Existing external reference for Proxmox UPS setup |
| [Racknerd setup](../docker/racknerd/setup.md) | Debian, SSH, firewall, and rootless Docker setup |
| [Photo server setup](../docker/photo-server/setup.md) | Disk mounts and host prerequisites |
| [Immich setup](../docker/photo-server/immich/setup.md) | Photo application setup notes |
| [SimpleLogin setup](../docker/racknerd/simple-login/setup.md) | Mail service and native Postfix setup |
| [Nextcloud bot setup](../docker/photo-server/nextcloud/nextcloud-bot-setup.md) | Nextcloud Talk bot configuration |
| [Proxmox setup](../tf/proxmox/SETUP.md) | Existing permissions and installation notes |
| [Home Assistant VM setup](../tf/proxmox/HASSIO-SETUP.md) | Existing image setup reference |

Service-specific `issues.md` files are linked from the corresponding host
README. They record troubleshooting history, not an exhaustive incident
response or recovery procedure.

## Adding a runbook

Explain its purpose, prerequisites, commands and working directory,
expected result, and recovery or rollback steps where applicable. Link the
runbook from its owning README and add it here when useful across areas.
Prefer relative Markdown links and Mermaid diagrams stored with the text.

**Maintenance:** review this index whenever a runbook is added, moved, or
removed. Follow [the maintenance requirements](documentation.md) in the
same change.

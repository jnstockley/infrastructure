# Databasus

[OpenTofu overview](../README.md)

This directory currently contains documentation only. There are no
provider, workspace, storage, webhook, variable, or lock files in this
checkout, so it is not an active OpenTofu root and cannot be validated or
planned here. Earlier documentation described files that are no longer
present; do not infer live backup configuration or state ownership from
those descriptions.

Databasus runs with PostgreSQL on the
[photo server](../../docker/photo-server/README.md) and
[Racknerd](../../docker/racknerd/README.md). See
[host services](../../services/README.md) for the separate verification
agent. The current Cloudflare, Authentik, and Uptime Kuma roots still
contain DNS, identity, or monitoring configuration for Databasus.

There is no Databasus job in `tf-state.yml` or matching OpenTofu Infisical
environment/OIDC subject. Restoring this root requires verified live
configuration, backend ownership, provider requirements, secret inputs,
and an explicit adoption plan. Do not initialize an empty directory and
assume it represents existing resources.

**Maintenance:** update this inventory when configuration is restored,
including the provider index, state diagram, automation coverage, and
affected consumers, following the
[documentation checklist](../../docs/documentation.md).

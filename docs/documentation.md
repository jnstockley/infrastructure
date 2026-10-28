# Required documentation maintenance

[Documentation index](README.md) · [Agent instructions](../AGENTS.md)

Markdown provides general guidance for maintaining the repository. It is
not a changelog, task log, or record of every configuration edit.

Do not update documentation for every change. Update it when architecture,
setup, dependencies, validation, deployment, or recovery guidance becomes
inaccurate, or when a new major section needs an overview. Routine resource
additions, monitor changes, version bumps, audit findings, and plan results
usually belong in configuration, commit messages, or the handoff/PR rather
than README prose. Keep needed documentation updates in the same change.

## Where general guidance lives

| Changed area | Relevant guidance |
| --- | --- |
| `docker/<host>/<service>/` | Host README, Docker overview, and service runbooks; review DNS, identity, and monitors if affected |
| Docker host or stack added/removed | Host inventory, Docker host index, and root README if the host changes |
| `tf/<provider>/` | Provider README, OpenTofu overview, and consumers of changed state outputs |
| OpenTofu root added/removed | OpenTofu provider index, state diagram, and automation coverage |
| `.github/` | Automation README and any affected deployment, test, or scan guide |
| `scripts/` | Scripts README and guides that use the changed command |
| `tests/`, `pyproject.toml`, `uv.lock` | Tests README and setup commands if prerequisites or behavior change |
| `trivy/` | Security scanning README and automation guide |
| `services/` | Host services README and related provider or host documentation |
| Runbooks or documentation structure | Owning README, documentation index, and inbound links |
| Repository-wide conventions | Root README, AGENTS.md, and this guide |

A change can cross several rows. For example, a new application can need a
host inventory entry, DNS records, an Authentik application, monitoring,
and updates to their respective guides.

## When documentation needs updating

1. Read the relevant overview or runbook when the change affects its
   instructions or architecture.
2. Correct affected guidance, links, examples, and diagrams. Add a linked
   README for a new major section, host, or OpenTofu root.
3. Validate Markdown and relative links for documents that changed. Keep
   diagram relationships consistent with the configuration.

Do not add prose solely to mark a document as reviewed or to describe the
latest implementation. There is no requirement to edit Markdown or list
reviewed documents in every handoff.

## Writing and diagram conventions

- Write for someone maintaining the repository without chat history.
- Identify source files and link to them. Distinguish configured behavior
  from verified live behavior and historical troubleshooting notes.
- Use Mermaid fences for architecture, dependencies, and workflows when a
  diagram explains relationships more clearly than a short paragraph.
- Describe whether arrows mean traffic, remote-state reads, or execution
  order. State dependencies do not necessarily imply a valid apply order.
- Show commands with their working directory and prerequisites. Explain
  whether a command only validates or changes a host or remote resources.
- Document environment variable names and secret sources; never copy live
  credentials, private keys, generated `.env` files, or state into docs.
- Keep inventories near the configuration. Link to exact versions in
  source files instead of duplicating version strings in prose.

The root AGENTS.md is the entry point for agent instructions. This guide
provides documentation scope and writing conventions.
These are repository requirements, not a technical guarantee that every
external tool or agent will load or obey them. Current Markdown CI checks
formatting; it cannot establish whether prose matches the implementation.

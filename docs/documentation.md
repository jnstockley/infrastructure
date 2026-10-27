# Required documentation maintenance

[Documentation index](README.md) · [Agent instructions](../AGENTS.md)

Documentation is part of implementing a change. **Every change requires a
documentation review before it is considered complete.** Update affected
documents in the same commit or PR as the configuration or code they
describe. This applies to humans and AI agents, including dependency
updates, removals, and changes made during a review.

## Find the documents to review

| Changed area | Required review |
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

## Completion checklist

1. Read the nearest README and applicable runbooks before editing.
2. Compare the implementation with descriptions of purpose, resources,
   dependencies, environment variables, ports, networks, storage, startup,
   validation, deployment, and recovery.
3. Update every affected description, table, example, link, and diagram.
   Add a README for a new major section, Docker host, or OpenTofu root.
   Remove obsolete entries when removing resources.
4. Validate Markdown and relative links. Check diagram nodes and arrows
   against actual configuration. An arrow must have a stated meaning.
5. Include documentation changes and validation in the handoff or PR. If
   no text needs changing, name the documents reviewed and explain why
   their descriptions remain accurate.

An image version update can require no prose edits when documentation
links to the Compose source instead of repeating versions. It still
requires reviewing changed behavior, requirements, and upgrade steps.
Do not make meaningless edits merely to mark a document as reviewed.

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
provides the detailed checklist; instructions require agents to read it.
These are repository requirements, not a technical guarantee that every
external tool or agent will load or obey them. Current Markdown CI checks
formatting; it cannot establish whether prose matches the implementation.

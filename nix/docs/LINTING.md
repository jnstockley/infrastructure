# Formatting & linting

Three tools, wired together behind one interface ([treefmt](https://github.com/numtide/treefmt)
via [treefmt-nix](https://github.com/numtide/treefmt-nix), configured in
`treefmt.nix`):

| Tool | What it does | Auto-fixable? |
|---|---|---|
| [**nixfmt**](https://github.com/NixOS/nixfmt) | The official Nix formatter (RFC 166) — consistent indentation, spacing, line-wrapping. No configuration knobs by design; the whole point is one canonical style. | Yes |
| [**statix**](https://github.com/oppiliappan/statix) | Lints for common anti-patterns — ambiguous `with` scoping, redundant `rec`, unnecessary `inherit`, etc. | No — flags issues, you fix them |
| [**deadnix**](https://github.com/astro/deadnix) | Finds genuinely unused code — unreferenced `let` bindings, unused function args, dead attrset keys. | No — flags issues, you fix them |

## Usage

**Auto-format everything:**
```bash
scripts/fmt.sh
# equivalent to: nix fmt
```
Only touches whitespace/layout, never semantics — safe to run anytime,
including on files you haven't looked at yet.

**Check formatting + lints without changing anything** (what CI runs):
```bash
scripts/lint.sh
# equivalent to: nix flake check
```
Exits non-zero if formatting is off or statix/deadnix found something.
Run this before committing.

**Format or check a single file directly**, without going through the
flake wrapper (useful for a quick one-off, or if you don't want to wait
for `nix flake check` to also re-evaluate everything else):
```bash
nix run nixpkgs#nixfmt -- path/to/file.nix
nix run nixpkgs#statix -- check path/to/file.nix
nix run nixpkgs#deadnix -- path/to/file.nix
```

## What a finding looks like

`scripts/lint.sh` failing on formatting just means you forgot to run
`scripts/fmt.sh` — fix with that, no thinking required.

A statix or deadnix finding is different — it's pointing at something
worth reading, not just restyling. Example statix warning:
```
warning[unquoted_uri]: Nix files should not contain unquoted URIs
  ┌─ modules/homebrew.nix:12:5
  │
12│     homepage = https://example.com;
  │                ^^^^^^^^^^^^^^^^^^^ found unquoted URI
```
Fix: quote the string. deadnix findings look similar but point at a
binding or argument that's declared and never used — usually a sign of a
leftover from refactoring; safe to delete once you confirm it's really
unused.

## Editor integration (optional)

Most editors will run `nix fmt` for you if you point their Nix language
extension at this repo's `flake.nix`. For a manual/VS Code-agnostic setup,
`nixfmt` also works standalone as a formatter binary — see its README for
editor-specific instructions: https://github.com/NixOS/nixfmt#editor-integration

## CI

`.github/workflows/ci.yml` runs `nix flake check` (same as `scripts/lint.sh`)
on every push and pull request, on a macOS runner so it matches the
`aarch64-darwin` system these configs actually target. A red check means
someone forgot to run `scripts/fmt.sh` or introduced something statix/deadnix
flags — fix locally, push again.

## Updating these tools

`nixfmt`, `statix`, and `deadnix` all come from the pinned `nixpkgs` input,
and `treefmt-nix` is its own flake input — both move together with the rest
of your dependencies via Renovate. See `docs/RENOVATE.md`. Nothing here
needs separate version tracking.

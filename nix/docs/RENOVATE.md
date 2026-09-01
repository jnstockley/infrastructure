# Automated updates with Renovate

Renovate keeps `flake.lock` — and therefore `nixpkgs` and `nix-darwin` —
up to date by opening pull requests, instead of you remembering to run
`nix flake update` yourself.

## What it covers

- **`nixpkgs` input**: every package installed via `environment.systemPackages`
  (see `docs/PACKAGES.md`) moves together with this. Renovate opens a PR
  whenever a newer `nixpkgs-unstable` commit is available.
- **`nix-darwin` input**: new nix-darwin features/fixes.
- **`flake.lock` maintenance**: a weekly "refresh everything" pass even if
  no individual input PR fired, so the lockfile doesn't silently go stale.

## What it does NOT cover

- **Homebrew brews/casks** (`modules/homebrew.nix`) — there's no Renovate
  manager for Brewfile-style entries, and there's nothing to pin: this
  config already sets `homebrew.onActivation.upgrade = true`, so Homebrew
  updates its own packages to latest on every `darwin-rebuild switch`
  automatically, no bot required.
- **Mac App Store apps** (`masApps`) — same story; the App Store always
  serves the latest version, there's no version to track or pin.

In other words: Renovate's job here is narrow but important — it's the
piece that makes the *reproducible* half of this setup (nixpkgs) stay
current without you doing it by hand, since that's the one part that
doesn't already auto-update itself.

## Setup (pick one)

**Option A — hosted Renovate GitHub App (easiest):**

1. Install <https://github.com/apps/renovate> on this repository.
2. That's it — `renovate.json` in this repo is already configured. Delete
   `.github/workflows/renovate.yml` so it doesn't run a redundant second
   copy.

**Option B — self-hosted via GitHub Actions:**

1. Keep `.github/workflows/renovate.yml`.
2. Create a GitHub personal access token with `contents: write` and
   `pull-requests: write` on this repo, add it as a repository secret
   named `RENOVATE_TOKEN`.
3. It runs on the schedule in the workflow file, or trigger it manually
   from the Actions tab (`workflow_dispatch`).

Either way, Renovate runs on GitHub's infrastructure — **not** on the Mac
Mini. It only ever proposes changes via pull request; nothing installs on
the Mini until you merge and then rebuild.

## The full update loop

```text
Renovate (weekly, on GitHub)
  → opens PR bumping nixpkgs/nix-darwin in flake.lock
  → you review the diff, merge (or let it auto-merge — see below)
  → on the Mac: scripts/update.sh
  → darwin-rebuild switch picks up the new, already-committed flake.lock
```

Note this means `scripts/update.sh mini --update-inputs` (which runs
`nix flake update` locally) becomes something you'd reach for less often —
mainly for an ad-hoc bump between Renovate's scheduled runs, or before
Renovate is set up at all.

## Reviewing / trusting the updates

nixpkgs and nix-darwin PRs are pinned by commit hash, not by trusting a
mutable tag, so a merged PR is exactly reproducible. Still worth actually
rebuilding (`scripts/install.sh`, which dry-runs first) before merging
anything that touches `system.stateVersion`-sensitive areas, and reading
the nix-darwin changelog if a PR bumps it by a large number of commits:
<https://github.com/nix-darwin/nix-darwin/releases>

If you'd rather not review every single bump by hand, you can let Renovate
auto-merge minor/patch-equivalent nixpkgs updates once your Mini has been
running long enough that you trust the loop — add to `renovate.json`:

```json
{
  "packageRules": [
    {
      "matchManagers": ["nix"],
      "matchDepNames": ["nixpkgs"],
      "automerge": true,
      "automergeType": "pr",
      "platformAutomerge": true
    }
  ]
}
```

Start without this. Turn it on once you're confident a bad nixpkgs bump
would be obvious quickly (and remember `scripts/rollback.sh` is always
right there if it isn't).

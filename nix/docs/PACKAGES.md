# Where should this app come from?

This config can install software three different ways. They behave
differently enough that the choice matters — this doc is the reference for
picking one.

|                   | **nixpkgs** (`environment.systemPackages`)                                   | **Homebrew formula** (`homebrew.brews`)                                                      | **Homebrew cask** (`homebrew.casks`)     | **Mac App Store** (`homebrew.masApps`)        |
|-------------------|------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------|------------------------------------------|-----------------------------------------------|
| Best for          | CLI tools, dev tooling                                                       | CLI tools not well-packaged in nixpkgs, or that need real macOS integration (Keychain, etc.) | GUI `.app` applications                  | App Store–exclusive apps (sandboxed, paid)    |
| Version pinning   | **Yes** — pinned by `flake.lock`                                             | No — always "latest" at rebuild time                                                         | No — always "latest"                     | No — App Store doesn't support pinning        |
| Rollback          | **Instant**, part of `darwin-rebuild switch --rollback`                      | No — brew mutates state directly, outside nix-darwin's generations                           | No                                       | No                                            |
| Stays current via | Bumping the `nixpkgs` input (Renovate can automate — see `docs/RENOVATE.md`) | `homebrew.onActivation.upgrade = true` on every rebuild                                      | same                                     | `mas upgrade`, triggered by brew's activation |
| Typical examples  | `ripgrep`, `jq`, `htop`, `terraform`, `node`, `python3`                      | `mas`, `ffmpeg`                                                                              | iTerm2, Rectangle, Docker Desktop, Slack | Xcode, Keynote, Pages                         |

## The short version

- **Command-line tool → nixpkgs, by default.** You get a reproducible,
  rollback-able version for free, and nixpkgs has ~120k packages, so most
  CLI tools already exist there. This is the main reason to bother with
  Nix at all instead of just a Brewfile.
- **Has a `.app` bundle / GUI → Homebrew cask.** nixpkgs *can* package some
  macOS GUI apps, but support is inconsistent — code signing, notarization,
  and Dock/Spotlight integration don't always work the way a "real" install
  does. Casks are the reliable path for anything with a window.
- **Only available on the App Store → `masApps`.** No alternative here.
- **A CLI tool exists in both nixpkgs and Homebrew → prefer nixpkgs.** Its
  version then becomes part of your reproducible state instead of quietly
  drifting every time Homebrew auto-upgrades it.

## Examples

**Adding a CLI tool via nixpkgs** (preferred path):

```nix
# modules/packages.nix
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ripgrep
    jq
    htop
    terraform   # <- just add the attribute name
  ];
}
```

Find the right attribute name first: <https://search.nixos.org/packages>
(or `nix search nixpkgs terraform` from a terminal that already has Nix).
Then `scripts/update.sh`.

**The same tools via Homebrew instead**, shown only for contrast — for CLI
tools this loses you pinning/rollback for no benefit:

```nix
# modules/homebrew.nix
homebrew.brews = [ "ripgrep" "jq" "htop" "terraform" ];
```

**Adding a GUI app** (Homebrew cask is the right tool here):

```nix
# modules/homebrew.nix
homebrew.casks = [
  "iterm2"
  "rectangle"
  "docker"
];
```

Find the exact cask name at <https://formulae.brew.sh/cask/> — it must match
exactly (e.g. `docker`, not `docker-desktop`).

**Adding an App Store app:**

```bash
mas search "Tailscale"     # find the numeric ID
```

```nix
# modules/homebrew.nix
homebrew.masApps = {
  "Tailscale" = 1475387142;
};
```

Requires being signed into the App Store GUI at least once first (see
README "Known limitations").

## Advanced: pinning one package to a different version than everything else

Normally every nixpkgs-sourced package moves together, because they all
come from the single `nixpkgs` input pinned in `flake.lock` — bump that
input, everything bumps together. Sometimes you want one exception (e.g.
you need `nodejs_18` specifically, but your main `nixpkgs` pin has moved
past it).

Add a second, independently-pinned `nixpkgs` input in `flake.nix`:

```nix
inputs.nixpkgs-pinned.url = "github:NixOS/nixpkgs/<commit-or-branch>";
```

Thread it through `mkHost`'s `specialArgs` alongside the default `pkgs`,
then reference it where you need the pinned version:

```nix
# modules/packages.nix
{ pkgs, pkgsPinned, ... }:
{
  environment.systemPackages = (with pkgs; [ ripgrep jq ])
    ++ [ pkgsPinned.nodejs_18 ];
}
```

Use this sparingly — every extra pinned input is one more thing Renovate
will (correctly) open update PRs for, and one more thing to reason about
when debugging a version mismatch.

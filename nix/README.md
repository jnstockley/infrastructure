# nix-mac-config

Declarative macOS setup for one or more Macs, using **nix-darwin** (no
home-manager — this repo only manages Homebrew packages/casks/App Store apps
and system defaults, not dotfiles/shell config).

Every rebuild is idempotent: run it once, run it a hundred times, the end
state is the same. Every rebuild is also reversible: nix-darwin keeps every
past "generation" so you can roll back instantly if something breaks.

---

## Directory layout

```
.
├── flake.nix                  # entry point: pins dependency versions, lists hosts
├── treefmt.nix                 # formatter/linter config (nixfmt, statix, deadnix)
├── renovate.json               # automated flake.lock / nixpkgs / nix-darwin updates
├── modules/                   # config shared by EVERY host
│   ├── nix-settings.nix       #   how Nix itself is managed
│   ├── packages.nix           #   CLI tools installed straight from nixpkgs
│   ├── homebrew.nix           #   brews / casks / Mac App Store apps
│   └── system-defaults.nix    #   dock/finder/keyboard prefs, SSH, etc.
├── hosts/
│   └── mini/
│       └── default.nix        # config specific to THIS Mac (hostname, user, overrides)
├── scripts/
│   ├── bootstrap.sh           # run ONCE on a brand-new Mac
│   ├── install.sh             # first activation with a dry-run safety check
│   ├── update.sh              # everyday command: pull + rebuild
│   ├── rollback.sh            # undo the last switch
│   ├── new-host.sh            # scaffold config for another Mac
│   ├── fmt.sh                 # auto-format all .nix files
│   ├── lint.sh                # check formatting + lints, no changes made
│   └── verify-defaults.sh     # spot-check that system.defaults settings actually landed
├── docs/
│   ├── PACKAGES.md            # nixpkgs vs Homebrew vs mas — when to use which
│   ├── RENOVATE.md            # how automated dependency updates work
│   ├── LINTING.md             # formatting/linting tools and usage
│   └── SYSTEM_SETTINGS.md     # which System Settings are scriptable, and how to find more
└── .github/workflows/
    ├── renovate.yml           # optional self-hosted Renovate (skip if using the hosted app)
    └── ci.yml                 # runs `nix flake check` on every push/PR
```

**Why split it this way?** `modules/` is the stuff you want identical across
every Mac you manage. `hosts/<name>/` is the handful of things that differ
per machine (hostname, your account name, maybe an extra cask). Adding a
second Mac means adding one small file and one line in `flake.nix` — the
shared modules are automatically reused.

---

## Prerequisites

- Apple Silicon or Intel Mac, macOS 13 (Ventura) or later
- Admin access (you'll be prompted for `sudo` during activation)
- A place to host this repo (GitHub/GitLab/etc.) once you're happy with it —
  git isn't required to *use* this config, but it's what makes "re-run it
  on another Mac" trivial

Nix itself is **not** installed yet — `scripts/bootstrap.sh` does that for
you using the [Determinate Systems installer](https://install.determinate.systems),
which is the currently-recommended way to install Nix on macOS (it handles
macOS-specific quirks around users, launchd, and shell profiles that the
plain community installer doesn't).

---

## First-time setup (brand-new Mac)

1. Get this repo onto the Mac (via `git clone`, AirDrop, USB — doesn't
   matter for the very first machine).
2. Open `hosts/mini/default.nix` and replace every `CHANGE_ME` with your
   actual short macOS username (check with `whoami`).
3. From the repo root:
   ```bash
   scripts/install-homebrew.sh
   ```
   This installs Homebrew, since nix-darwin's Homebrew module assumes it's 
   already present. You can skip this if you already have Homebrew installed, 
   but nix-darwin will still manage it from
4. From the repo root:
   ```bash
   scripts/bootstrap.sh mini
   ```
   This installs Xcode Command Line Tools if needed, installs Nix if
   needed, and does the first `nix-darwin` activation. It's safe to just
   re-run it if it stops partway (e.g. to wait for a GUI installer, or for
   you to open a new terminal so PATH changes take effect).
5. Once it finishes, open `modules/homebrew.nix` and start uncommenting /
   adding the casks, brews, and App Store apps you actually want, then:
   ```bash
   scripts/update.sh
   ```
   
6. Setup GitHub Authentication using GH:
    ```bash
    gh auth login
    ```

---

## Day-to-day workflow

1. Edit a `.nix` file (add a cask, change a dock setting, whatever).
2. `scripts/fmt.sh` — auto-format (optional but cheap; CI checks this anyway).
3. `scripts/update.sh` — pulls the latest committed config (if this is a
   git repo) and activates it.
4. If something looks wrong, `scripts/rollback.sh` — instant, no rebuild.

If you want a dry-run check before committing to a change (useful right
after editing something you're not fully sure about), use
`scripts/install.sh` instead of `update.sh` — it runs `nix build --dry-run`
first and asks for confirmation before switching.

Commit every change to git, including `flake.lock` (see below). That's what
turns "config I ran once" into "config I can reproduce anywhere."

---

## Installing apps

Three different sources, each behaving differently (pinned vs. always-latest,
rollback-able vs. not): `environment.systemPackages` (nixpkgs),
`homebrew.brews`/`homebrew.casks` (Homebrew), and `homebrew.masApps` (App
Store). Full decision guide with worked examples: **[docs/PACKAGES.md](docs/PACKAGES.md)**.

Short version: CLI tools → nixpkgs (`modules/packages.nix`), GUI apps →
Homebrew casks (`modules/homebrew.nix`), App Store–exclusive apps → `mas`.

---

## Formatting & linting

`scripts/fmt.sh` auto-formats every `.nix` file (nixfmt); `scripts/lint.sh`
checks formatting plus runs statix/deadnix without changing anything — same
check CI runs on every push. Details: **[docs/LINTING.md](docs/LINTING.md)**.

---

## Managing updates

Two independent things update on different schedules:

**Your own config** (`modules/*.nix`, `hosts/*/default.nix`) — you edit
these directly and `git commit` as normal.

**Upstream dependencies** (nixpkgs, nix-darwin) — pinned in `flake.lock`,
which is auto-generated and should be committed to git. This is what makes
a rebuild six months from now install the *exact* same package versions as
today, instead of silently drifting.

To pull in newer package versions / newer nix-darwin features by hand:
```bash
scripts/update.sh mini --update-inputs
```
This runs `nix flake update`, rebuilds, and if it works, updates
`flake.lock`. **Review the diff before committing** — `git diff flake.lock`
— and if the rebuild broke something, `git checkout flake.lock` to revert
to the last known-good pin instead of debugging live.

This repo also ships a **Renovate** config (`renovate.json`) that does this
part automatically — it opens a pull request whenever `nixpkgs` or
`nix-darwin` have new commits, so you review a diff instead of remembering
to run the command above yourself. Setup and details:
**[docs/RENOVATE.md](docs/RENOVATE.md)**. Note it only covers nixpkgs —
Homebrew and Mac App Store apps already self-update on every rebuild (see
`docs/PACKAGES.md` for why there's nothing to pin there).

To clean up old build artifacts and reclaim disk space:
```bash
nix-collect-garbage --delete-older-than 30d   # keep last 30 days
sudo darwin-rebuild --list-generations         # see what's still kept
```

---

## Adding another Mac

```bash
scripts/new-host.sh macbook
```
Follow the printed instructions (edit the placeholder username, add one
line to `flake.nix`, commit/push). Then on the new Mac:
```bash
git clone <your-repo-url>
cd nix-mac-config
scripts/bootstrap.sh macbook
```
Any module you already wrote (Homebrew list, system defaults) applies
automatically — you're only writing the handful of things unique to that
machine.

---

## Best practices

- **Commit `flake.lock`.** Without it, "reproducible" is a lie — you'd get
  whatever nixpkgs happened to be at HEAD on rebuild day.
- **Small, single-purpose commits.** A bad Dock setting is a one-line
  `git revert`; a giant commit that also touched Homebrew and SSH is not.
- **Leave `homebrew.onActivation.cleanup` on `"none"` until your list is
  complete**, then switch to `"zap"`. `"zap"` will genuinely uninstall
  anything on the Mac not listed in `modules/homebrew.nix` — great for
  drift-prevention, unpleasant the first time you forget to list something
  you use daily.
- **Use `scripts/install.sh` (dry-run first) for changes you're unsure
  about; `scripts/update.sh` for routine ones.**
- **Run `scripts/lint.sh` before committing** (or just let CI catch it) —
  a red formatting/statix/deadnix check is cheap to fix immediately and
  annoying to untangle three commits later.
- **Don't hand-edit files under `/nix/store`** — it's read-only by design,
  and anything you change outside the Nix config will be silently
  overwritten or ignored on the next switch. If you want something to
  persist, it belongs in a `.nix` file.
- **Treat `system.stateVersion` as write-once.** It marks the nix-darwin
  schema your config was originally written against; bumping it later can
  change defaults out from under you. Leave it alone after first
  activation.
- **No secrets in this repo.** There's no home-manager/agenix/sops-nix
  wired up here, so don't put API tokens, Wi-Fi passwords, etc. into any
  `.nix` file — this repo is likely to end up in a public or
  semi-shared git remote. Keep secrets in the macOS Keychain, 1Password,
  or similar, managed outside this config for now.

---

## Known limitations (read before you rely on this headlessly)

- **Not everything in System Settings is scriptable.** `system.defaults`
  covers Dock/Finder/keyboard/etc. well, but Apple has moved a growing set
  of panes (parts of Notifications, Privacy & Security, iCloud) off the
  old `defaults write` mechanism entirely in recent macOS versions. Full
  reference — what's covered by typed options, the `CustomUserPreferences`
  escape hatch, and what's not reachable at all: **[docs/SYSTEM_SETTINGS.md](docs/SYSTEM_SETTINGS.md)**.
- **Privacy permissions (Full Disk Access, Accessibility, Screen
  Recording) cannot be granted by any script**, including this one.
  Apple blocks this deliberately. For a headless box you'll need to grant
  these once via Screen Sharing/physical access, or enroll the Mac in an
  MDM (even a free Apple Business Manager + something like Kandji) and
  push a PPPC configuration profile.
- **`mas` (Mac App Store CLI) requires you to already be signed into the
  App Store GUI** on macOS 12+ — it can't sign you in itself. Do this once
  by hand before `masApps` entries will install.
- **Remote Login / SSH**: this config turns on `services.openssh`, but
  before the Mac is truly headless, also run once by hand:
  `sudo systemsetup -setremotelogin on`, and disable sleep
  (`sudo pmset -a sleep 0`, adjust to taste) so it stays reachable.
- **FileVault + headless reboots don't mix well** without extra work — if
  disk encryption is on, a reboot needs `fdesetup authrestart` scheduled
  via launchd to auto-unlock, or you decide deliberately to leave
  FileVault off on this box in exchange for simpler unattended reboots.

---

## Troubleshooting

**"error: refusing to set up ... conflicting files"** during first
activation — usually `/etc/zshenv`, `/etc/bashrc`, etc. already exist from
a prior setup. Back them up and retry:
```bash
sudo mv /etc/zshenv /etc/zshenv.before-nix-darwin
```

**`nix: command not found` right after the installer finishes** — open a
brand-new terminal window/tab; the installer updates shell profiles that
your *current* shell already loaded before the change.

**Homebrew casks fail with a permissions or "already exists" error** — an
app installed manually outside this config is conflicting. Either delete
it from `/Applications` and let nix-darwin install it, or add it to
`modules/homebrew.nix` so it's recognized as managed.

**Want to know what changed between two generations?**
```bash
darwin-rebuild --list-generations
nix store diff-closures /nix/var/nix/profiles/system-<OLD>-link /nix/var/nix/profiles/system-<NEW>-link
```

---

## References

- nix-darwin manual: https://nix-darwin.github.io/nix-darwin/manual/
- nix-darwin option search: https://search.nixos.org/search?channel=unstable&flake=nix-darwin
- nixpkgs package search: https://search.nixos.org/packages
- Determinate Nix installer: https://determinate.systems/nix-installer/
- `mas` (App Store CLI): https://github.com/mas-cli/mas

# System Settings reference

What `system.defaults` in this repo can and can't reach, and how to find out
for anything not already covered.

## How this actually works

nix-darwin's `system.defaults.*` options are a typed Nix wrapper around the
same mechanism `defaults write` has always used: each option maps to a key
in a macOS preferences domain (a `.plist` under `~/Library/Preferences/` or
`/Library/Preferences/`). On `darwin-rebuild switch`, nix-darwin writes all
configured values and, for a handful of domains it knows about (Dock,
Finder, SystemUIServer), restarts the owning process so the change takes
effect without a logout.

This means **anything true of `defaults write` in general is true here
too** — including its limitations. nix-darwin doesn't unlock anything
Apple hasn't already exposed through that mechanism; it just gives you a
typed, documented, version-controlled way to drive it.

## Typed option groups (the reliable path)

nix-darwin currently ships ~210 typed options across the groups below.
Typed means: documented, type-checked at build time (so a typo or wrong
type fails `darwin-rebuild switch` instead of silently doing nothing), and
covered by the nix-darwin manual/option search tools.

| Group | Covers | Used in this repo |
|---|---|---|
| `dock` | Size, position, autohide, hot corners, persistent apps/spacers | `modules/system-defaults.nix` |
| `finder` | View style, path/status bar, extensions, desktop icons | `modules/system-defaults.nix` |
| `trackpad` | Tap to click, tap-to-drag, click pressure, gestures | not yet used — see example below |
| `NSGlobalDomain` | Cross-app settings: key repeat, dark mode, text substitution, scroll direction | `modules/system-defaults.nix` (partial) |
| `screencapture` | Screenshot location, file format, shadow | not yet used |
| `screensaver` | Password-after-sleep delay, screen saver module | `modules/system-defaults.nix` (partial) |
| `menuExtraClock` | 24-hour time, seconds, date format in the menu bar | not yet used |
| `loginwindow` | Login screen text, guest account, fast user switching | not yet used |
| `spaces` | Spaces-per-display behavior | not yet used |
| `WindowManager` | Stage Manager, tiling behavior (Sonoma+) | not yet used |
| `controlcenter` | Which Control Center modules show in the menu bar | not yet used |
| `universalaccess` | Accessibility: zoom, contrast, reduce motion | not yet used |
| `magicmouse` | Magic Mouse gestures | n/a (headless Mini) |
| `hitoolbox` | Input source / keyboard layout switching | not yet used |
| `iCal` | Calendar.app defaults | not yet used |
| `LaunchServices` | Quarantine warnings for downloaded apps | not yet used |
| `smb` | File sharing (NetBIOS name, etc.) | not yet used |
| `SoftwareUpdate` | Auto-check/auto-download behavior | not yet used |
| `ActivityMonitor` | Default columns, sort order, dock icon | not yet used |

Full current list with types and defaults: search
https://search.nixos.org/search?channel=unstable&query=system.defaults&flake=nix-darwin
or browse https://mynixos.com/nix-darwin/options/system.defaults (community
mirror of the same option data, sometimes easier to skim). Canonical source
is the module code itself:
https://github.com/nix-darwin/nix-darwin/tree/master/modules/system/defaults

## The escape hatch: `CustomUserPreferences` / `CustomSystemPreferences`

Most preference keys that exist on macOS do **not** have a typed
nix-darwin option — the ~210 above are the commonly-requested subset.
For anything else, if it's a plain `defaults write`-style key, you can set
it directly:

```nix
# modules/system-defaults.nix (or any module)
system.defaults.CustomUserPreferences = {
  "com.apple.finder" = {
    QuitMenuItem = true; # allow Cmd+Q to quit Finder — no typed option for this one
  };
  NSGlobalDomain = {
    WebKitDeveloperExtras = true;
  };
};

# System-wide (root-owned) domains use CustomSystemPreferences instead:
system.defaults.CustomSystemPreferences = {
  "/Library/Preferences/com.apple.something" = {
    SomeKey = true;
  };
};
```

**Caveats, from real-world reports, not hypothetical:**
- Some domains only take effect after the owning process restarts or you
  log out/in — nix-darwin restarts Dock/Finder/SystemUIServer
  automatically, but not arbitrary apps.
- A `defaults write` to a domain owned by a *running, sandboxed* app can
  silently write to the wrong container instead of the plist the app
  actually reads — this has been observed to change between macOS
  versions for the same key without warning, so a value that worked on
  one macOS release can quietly stop applying on the next.
- If a value doesn't seem to "take" after a clean `darwin-rebuild switch`,
  check with `defaults read <domain> <key>` (see verification below)
  before assuming your Nix syntax is wrong — often the write succeeded
  and the *app* just hasn't picked it up yet.

## Finding the right domain/key for something new

1. Check if it's already a typed option first (search links above) — typed
   is always preferable when available.
2. If not, find the exact domain and key macOS itself uses:
   ```bash
   # snapshot preferences before
   defaults read > /tmp/before.txt
   # change the setting by hand in System Settings
   defaults read > /tmp/after.txt
   diff /tmp/before.txt /tmp/after.txt
   ```
   Whatever domain/key shows up in the diff is what goes into
   `CustomUserPreferences`.
3. Community references that catalogue individual keys (useful for
   *finding* a key; always verify against the diff method above before
   trusting it, especially on the newest macOS release):
   - https://macos-defaults.com — organized by System Settings pane, shows
     which macOS versions each command is confirmed on
   - https://ss64.com/osx/defaults.html — general `defaults` command
     reference
   - https://github.com/yannbertrand/macos-defaults — same data as
     macos-defaults.com, as a searchable repo

## What isn't reachable this way at all

Not a nix-darwin limitation specifically — none of these are reachable by
plain `defaults write` either, on any current macOS version:

- **TCC/privacy permissions** (Full Disk Access, Accessibility, Screen
  Recording, Camera/Microphone access) — deliberately blocked from
  scripted changes. Covered already in the main README's "Known
  limitations."
- **Notification Center settings** and parts of the redesigned System
  Settings app (Sonoma/Sequoia/Tahoe) — Apple has moved a growing set of
  panes to internal, non-plist-backed storage. If the diff method above
  shows no change in any `.plist` after toggling something, that's usually
  why.
- **iCloud account state / Focus modes / Screen Time content** — tied to
  signed-in account state and synced storage, not local preference files.
- **FileVault status** — has its own tool (`fdesetup`), not `defaults`;
  out of scope for `system.defaults` entirely.

If you hit one of these, the realistic options are: set it once by hand
(document that it's manual in a comment near the relevant module), or —
for a fleet of Macs — push it via an MDM configuration profile instead,
which operates below the layer these limitations live at.

## Verifying a setting actually applied

After `darwin-rebuild switch`, run `scripts/verify-defaults.sh` for a quick
spot-check of the settings already configured in this repo, or check any
key by hand:
```bash
defaults read com.apple.dock autohide
defaults read com.apple.finder AppleShowAllExtensions
defaults read NSGlobalDomain KeyRepeat
```
Returns the current value macOS has on file — if it doesn't match what
you set, re-check the domain/key against the diff method above rather than
assuming nix-darwin failed silently (it errors loudly on a bad option
name; a value that's simply not being *read* by the app is a different,
more common problem).

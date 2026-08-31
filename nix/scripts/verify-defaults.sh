#!/usr/bin/env bash
# Spot-checks that settings configured in modules/system-defaults.nix
# actually landed, by reading them back with `defaults read`. Useful right
# after a rebuild, or when debugging "I set this but it doesn't look
# changed" — see docs/SYSTEM_SETTINGS.md for why that sometimes happens.
#
# Extend the list below as you add more settings to modules/system-defaults.nix.
set -uo pipefail # no -e: a missing/unset key is a normal, expected result here

check() {
  local domain="$1" key="$2"
  local value
  value="$(defaults read "$domain" "$key" 2>&1)"
  printf "%-45s %-30s %s\n" "$domain" "$key" "$value"
}

echo "==> Current values on this Mac (compare against modules/system-defaults.nix):"
printf "%-45s %-30s %s\n" "DOMAIN" "KEY" "VALUE"
check "com.apple.dock" "autohide"
check "com.apple.dock" "show-recents"
check "com.apple.finder" "AppleShowAllExtensions"
check "com.apple.finder" "FXPreferredViewStyle"
check "NSGlobalDomain" "AppleShowAllExtensions"
check "NSGlobalDomain" "KeyRepeat"
check "com.apple.screensaver" "askForPasswordDelay"

echo ""
echo "A value showing 'does not exist' usually means either:"
echo "  - it hasn't been set to anything yet (fine if you haven't added it), or"
echo "  - it landed in a different domain than expected — see"
echo "    docs/SYSTEM_SETTINGS.md 'Finding the right domain/key for something new'"

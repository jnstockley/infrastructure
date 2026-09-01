#!/usr/bin/env bash
# Scaffold a new host when you're ready to bring another Mac under this
# same config. Run this on any machine (doesn't need Nix installed) —
# it just edits files in the repo.
#
# Usage: scripts/new-host.sh <hostname>
set -euo pipefail

NEW_HOST="${1:?Usage: scripts/new-host.sh <hostname>}"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

if [[ -d "hosts/${NEW_HOST}" ]]; then
    echo "hosts/${NEW_HOST} already exists — nothing to do."
    exit 1
fi

mkdir -p "hosts/${NEW_HOST}"
cat >"hosts/${NEW_HOST}/default.nix" <<EOF
{ pkgs, ... }:
{
  networking.hostName = "${NEW_HOST}";
  networking.computerName = "${NEW_HOST}";
  networking.localHostName = "${NEW_HOST}";

  system.primaryUser = "CHANGE_ME";
  users.users.CHANGE_ME = {
    home = "/Users/CHANGE_ME";
  };

  # Host-specific overrides go here, e.g.:
  # homebrew.casks = [ "iterm2" ];
}
EOF

echo "Created hosts/${NEW_HOST}/default.nix"
echo ""
echo "Next steps:"
echo "  1. Edit hosts/${NEW_HOST}/default.nix and replace CHANGE_ME"
echo "  2. In flake.nix, inside darwinConfigurations add:"
echo "       ${NEW_HOST} = mkHost { hostname = \"${NEW_HOST}\"; };"
echo "     (add 'system = \"x86_64-darwin\";' too if it's an Intel Mac)"
echo "  3. git add, commit, push"
echo "  4. On the new Mac: clone this repo, then run"
echo "       scripts/bootstrap.sh ${NEW_HOST}"

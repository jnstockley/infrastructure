#!/usr/bin/env bash
# Build + activate a host config, with a dry-run check first.
# Use this the first time you activate a host that's already had
# scripts/bootstrap.sh run on it (Nix + nix-darwin already present),
# or any time you want the extra "does this even build" safety check
# before switching.
#
# Usage: scripts/install.sh [hostname]     (defaults to "mini")
set -euo pipefail

HOSTNAME_TARGET="${1:-mini}"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

echo "==> Dry-run build for host: ${HOSTNAME_TARGET}"
nix build ".#darwinConfigurations.${HOSTNAME_TARGET}.system" --dry-run

echo ""
read -r -p "Dry run looks clean — proceed with activation? [y/N] " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Aborted. Nothing was changed."
    exit 1
fi

sudo darwin-rebuild switch --flake ".#${HOSTNAME_TARGET}"

echo ""
echo "==> Activated. Current generations:"
sudo darwin-rebuild --list-generations | tail -5

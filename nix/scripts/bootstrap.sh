#!/usr/bin/env bash
# One-time setup for a brand-new Mac. Safe to re-run if it fails partway —
# every step below checks whether it's already done before doing it again.
#
# Usage: scripts/bootstrap.sh [hostname]     (defaults to "mini")
set -euo pipefail

HOSTNAME_TARGET="${1:-mini}"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

echo "==> Target host: ${HOSTNAME_TARGET}"

# --- 1. Xcode Command Line Tools (git, clang, etc. — Nix wants these) ------
if ! xcode-select -p &>/dev/null; then
  echo "==> Installing Xcode Command Line Tools (a GUI prompt will appear)..."
  xcode-select --install
  echo "    Re-run this script after that install finishes."
  exit 0
fi

# --- 2. Nix itself ----------------------------------------------------------
if ! command -v nix &>/dev/null; then
  echo "==> Installing Nix via the Determinate Systems installer..."
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix \
    | sh -s -- install
  echo ""
  echo "Nix is installed. Open a NEW terminal window (so the shell picks up"
  echo "Nix's PATH changes), then re-run: scripts/bootstrap.sh ${HOSTNAME_TARGET}"
  exit 0
fi
echo "==> Nix found: $(nix --version)"

# --- 3. First-ever nix-darwin activation ------------------------------------
# `darwin-rebuild` doesn't exist as a command until nix-darwin has activated
# at least once, so the very first run goes through `nix run` instead.
if ! command -v darwin-rebuild &>/dev/null; then
  echo "==> First activation for host '${HOSTNAME_TARGET}' (this can take a while)..."
  sudo nix run nix-darwin/master#darwin-rebuild -- switch \
    --flake ".#${HOSTNAME_TARGET}"
else
  echo "==> nix-darwin already installed — activating current config..."
  sudo darwin-rebuild switch --flake ".#${HOSTNAME_TARGET}"
fi

echo ""
echo "==> Done. From now on:"
echo "      - change config, then run: scripts/update.sh ${HOSTNAME_TARGET}"
echo "      - undo a bad change with:  scripts/rollback.sh"

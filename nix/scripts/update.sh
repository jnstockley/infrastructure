#!/usr/bin/env bash
# Everyday driver. Pulls the latest committed config and re-activates it.
# This is the ONLY script you should need most of the time.
#
# Usage:
#   scripts/update.sh                    # pull + rebuild "mini"
#   scripts/update.sh macbook            # pull + rebuild a different host
#   scripts/update.sh mini --update-inputs   # also bump nixpkgs/nix-darwin
#                                              to their latest commits first
set -euo pipefail

HOSTNAME_TARGET="${1:-mini}"
UPDATE_INPUTS="${2:-}"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

if [[ -d .git ]]; then
  echo "==> Pulling latest config from git..."
  git pull --ff-only
else
  echo "==> Not a git repo (or .git missing) — skipping pull."
fi

if [[ "$UPDATE_INPUTS" == "--update-inputs" ]]; then
  echo "==> Updating flake inputs (nixpkgs, nix-darwin) to their latest commits..."
  nix flake update
  echo "    flake.lock changed — remember to 'git add flake.lock && git commit'"
  echo "    once you've confirmed the rebuild below works."
fi

echo "==> Rebuilding and activating host: ${HOSTNAME_TARGET}"
sudo darwin-rebuild switch --flake ".#${HOSTNAME_TARGET}"

echo ""
echo "==> Current generations:"
darwin-rebuild --list-generations | tail -5

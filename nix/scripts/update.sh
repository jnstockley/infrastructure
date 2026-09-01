#!/usr/bin/env bash
# Everyday driver. Pulls the latest committed config and re-activates it.
# This is the ONLY script you should need most of the time.
#
# Usage:
#   scripts/update.sh                    # pull + rebuild "mini"
#   scripts/update.sh macbook            # pull + rebuild a different host
#   scripts/update.sh mini --update-inputs   # also bump nixpkgs/nix-darwin
#                                              to their latest commits first,
#                                              then commit + push flake.lock
#                                              once the rebuild succeeds
set -euo pipefail

HOSTNAME_TARGET="${1:-mini}"
UPDATE_INPUTS="${2:-}"

# flake.nix lives in nix/ — Nix commands (flake update, darwin-rebuild) need
# to run from there. The git repo root is one level up from that — git
# commands (pull/add/commit/push) need to run from there instead.
NIX_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GIT_ROOT="$(cd "$NIX_DIR" && git rev-parse --show-toplevel 2>/dev/null || true)"

if [[ -n "$GIT_ROOT" ]]; then
  echo "==> Pulling latest config from git..."
  git -C "$GIT_ROOT" pull --ff-only
else
  echo "==> Not a git repo (or git not found) — skipping pull."
fi

cd "$NIX_DIR"

LOCKFILE_CHANGED=0
if [[ "$UPDATE_INPUTS" == "--update-inputs" ]]; then
  echo "==> Updating flake inputs (nixpkgs, nix-darwin) to their latest commits..."
  nix flake update

  if [[ -n "$GIT_ROOT" ]] && ! git -C "$GIT_ROOT" diff --quiet -- nix/flake.lock; then
    LOCKFILE_CHANGED=1
  else
    echo "==> flake.lock unchanged — nothing to commit."
  fi
fi

echo "==> Rebuilding and activating host: ${HOSTNAME_TARGET}"
sudo darwin-rebuild switch --flake ".#${HOSTNAME_TARGET}"

# Only commit/push the new flake.lock once the rebuild above has actually
# succeeded — `set -e` means a failed rebuild exits before we ever get here,
# so a broken lockfile never gets pushed.
if [[ "$LOCKFILE_CHANGED" -eq 1 ]]; then
  echo "==> Rebuild succeeded — committing and pushing updated flake.lock..."
  git -C "$GIT_ROOT" add nix/flake.lock
  git -C "$GIT_ROOT" commit -m "nix: update flake.lock"
  git -C "$GIT_ROOT" push
fi

echo ""
echo "==> Current generations:"
sudo darwin-rebuild --list-generations | tail -5

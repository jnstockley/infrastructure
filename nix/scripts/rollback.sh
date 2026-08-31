#!/usr/bin/env bash
# Every `darwin-rebuild switch` creates a new numbered "generation" without
# deleting the old one. This lets you step back to exactly what was running
# before, instantly, with no rebuild needed.
set -euo pipefail

echo "==> Available generations:"
darwin-rebuild --list-generations
echo ""

read -r -p "Roll back to the PREVIOUS generation? [y/N] " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
  sudo darwin-rebuild switch --rollback
  echo "==> Rolled back."
else
  echo ""
  echo "To roll back to a specific generation number instead, run:"
  echo "  sudo darwin-rebuild switch --switch-generation <N>"
fi

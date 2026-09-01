#!/usr/bin/env bash
# Checks formatting (nixfmt) and lints (statix, deadnix) WITHOUT modifying
# any files — exits non-zero if anything's off. This is what CI runs; run
# it yourself before committing to catch the same thing locally.
#
# Found something to fix? `scripts/fmt.sh` auto-fixes formatting; statix
# and deadnix findings need a manual look (they're pointing at real
# anti-patterns or dead code, not just style).
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

echo "==> Checking formatting + lints (nixfmt, statix, deadnix)..."
nix flake check
echo "==> All clean."

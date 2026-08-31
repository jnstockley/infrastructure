#!/usr/bin/env bash
# Auto-formats every .nix file in the repo (nixfmt, via treefmt) and
# rewrites files in place. Safe to run anytime — it only changes
# whitespace/layout, never semantics.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

nix fmt

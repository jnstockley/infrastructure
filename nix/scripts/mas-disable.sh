#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 <file-path>"
  exit 2
}

if [ "${1:-}" = "" ]; then
  usage
fi

file="${1}"

echo "Processing file: $file"

# Expand leading tilde if present
if [[ "$file" == ~* ]]; then
  file="${file/#\~/$HOME}"
fi

if [ ! -f "$file" ]; then
  echo "File not found: $file" >&2
  exit 1
fi

# macOS/BSD sed in-place edit
sed -i '' '/masApps = {/,/};/d' "$file"

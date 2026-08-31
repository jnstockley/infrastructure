#!/usr/bin/env bash
# Install Homebrew on macOS if it's not already installed.
set -euo pipefail
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

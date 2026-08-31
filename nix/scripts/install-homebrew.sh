#!/usr/bin/env bash
# Install Homebrew on macOS if it's not already installed, then wire it into
# the shell PATH. Safe to re-run — every step below checks whether it's
# already done before doing it again.
#
# Usage: scripts/install-homebrew.sh
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "==> This script only supports macOS. Aborting." >&2
  exit 1
fi

# --- Prime sudo -------------------------------------------------------------
# The official Homebrew installer needs sudo (to create/chown its prefix,
# e.g. /opt/homebrew) even when run non-interactively. Rather than hardcoding
# `sudo` in front of brew commands (which corrupts Homebrew's expected
# ownership model), we cache a sudo ticket up front and keep it alive for the
# duration of this script, so the installer's own internal `sudo` calls don't
# hang waiting on a password prompt.
echo "==> This script needs sudo access to install Homebrew. You may be prompted for your password."
sudo -v

# Refresh the cached credential every 60s in the background until this
# script exits, then clean up the background job automatically.
( while true; do sudo -n true; sleep 60; kill -0 "$$" 2>/dev/null || exit; done ) 2>/dev/null &
SUDO_KEEPALIVE_PID=$!
trap 'kill "$SUDO_KEEPALIVE_PID" 2>/dev/null || true' EXIT

# Homebrew's prefix differs by CPU architecture.
if [[ "$(uname -m)" == "arm64" ]]; then
  BREW_PREFIX="/opt/homebrew"
else
  BREW_PREFIX="/usr/local"
fi
BREW_BIN="${BREW_PREFIX}/bin/brew"

if command -v brew &>/dev/null; then
  echo "==> Homebrew already installed: $(brew --version | head -1)"
else
  echo "==> Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ ! -x "$BREW_BIN" ]]; then
  echo "==> Homebrew install did not produce ${BREW_BIN} — aborting." >&2
  exit 1
fi

# --- Post-install: put brew on PATH for future shells -----------------------
PROFILE_FILE="${HOME}/.zprofile"
SHELLENV_LINE="eval \"\$(${BREW_BIN} shellenv)\""

if ! grep -qsF "$SHELLENV_LINE" "$PROFILE_FILE" 2>/dev/null; then
  echo "==> Adding Homebrew shellenv to ${PROFILE_FILE}..."
  {
    echo ""
    echo "# Added by scripts/install-homebrew.sh"
    echo "$SHELLENV_LINE"
  } >> "$PROFILE_FILE"
else
  echo "==> ${PROFILE_FILE} already configures Homebrew shellenv."
fi

# Load it into the current shell too, so the rest of this script (and this
# terminal session, if sourced) can use `brew` immediately.
eval "$("$BREW_BIN" shellenv)"

echo "==> Running brew doctor..."
brew doctor || true

echo ""
echo "==> Done. Homebrew is on PATH via ${PROFILE_FILE}."
echo "    Open a NEW terminal window (or run: source ${PROFILE_FILE})"
echo "    so the shell picks up the change."

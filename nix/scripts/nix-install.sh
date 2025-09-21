#!/usr/bin/env bash
set -e

# Check if Nix is already installed
if ! command -v nix &>/dev/null; then
    # Download and install Nix
    curl -sSf -L https://install.lix.systems/lix | sh -s -- install macos --enable-flakes
    # Source the Nix environment in the current shell
    # shellcheck disable=SC1091
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

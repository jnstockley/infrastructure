#!/usr/bin/env bash
set -e

# Check if Rosetta 2 is installed
if ! (arch -arch x86_64 uname -m >/dev/null); then
    echo "Rosetta 2 is not installed. Installing Rosetta 2…"
    # Installing Rosetta 2
    softwareupdate --install-rosetta --agree-to-license
else
    echo "Rosetta 2 is installed."
fi

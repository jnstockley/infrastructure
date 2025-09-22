#!/usr/bin/env bash
set -e

echo "Checking Command Line Tools for Xcode"
# Only run if the tools are not installed yet
# To check that try to print the SDK path

if ! xcode-select -p &>/dev/null; then
    echo "Command Line Tools for Xcode not found. Installing from softwareupdate…"
    softwareupdate -l
    # This temporary file prompts the 'softwareupdate' utility to list the Command Line Tools
    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    PROD=$(softwareupdate -l | grep "\*.*Command Line" | tail -n 1 | sed 's/^[^C]* //')
    softwareupdate -i "$PROD" --verbose
else
    echo "Command Line Tools for Xcode have been installed."
fi

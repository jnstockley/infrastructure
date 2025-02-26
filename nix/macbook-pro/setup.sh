#!/usr/bin/env bash
set -e

echo "Checking Command Line Tools for Xcode"
# Only run if the tools are not installed yet
# To check that try to print the SDK path

if ! xcode-select -p &>/dev/null; then
    echo "Command Line Tools for Xcode not found. Installing from softwareupdate…"
    # This temporary file prompts the 'softwareupdate' utility to list the Command Line Tools
    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    PROD=$(softwareupdate -l | grep "\*.*Command Line" | tail -n 1 | sed 's/^[^C]* //')
    softwareupdate -i "$PROD" --verbose
else
    echo "Command Line Tools for Xcode have been installed."
fi

# Download and install Nix
sh <(curl -L https://nixos.org/nix/install) --daemon --yes

# Source the Nix environment in the current shell
# shellcheck disable=SC1091
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

mkdir -p ~/Documents/GitHub/Infrastructure/

mkdir -p ~/.config/nix

# Check if GITHUB_ACTION is set and doesn't equals 1
if [ "${GITHUB_ACTION}" != "1" ]; then
    git clone https://github.com/jnstockley/infrastructure.git ~/Documents/GitHub/Infrastructure/
else
    echo $GITHUB_WORKSPACE
    ls -s ~/Documents/GitHub/Infrastructure/ $GITHUB_WORKSPACE
    # Set GITHUB_TOKEN for authenticated git commands
    export GITHUB_TOKEN=${GITHUB_TOKEN}
fi

ln -s ~/Documents/GitHub/Infrastructure/nix/macbook-pro/flake.nix ~/.config/nix/flake.nix
# ln -s ~/Documents/GitHub/Infrastructure/nix/macbook-pro/flake.lock ~/.config/nix/flake.lock

nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/nix#macbook --impure

exec "$SHELL"

#!/usr/bin/env bash

sudo xcode-select --install &>/dev/null

# Download and install Nix
sh <(curl -L https://nixos.org/nix/install) --daemon --yes

# Source the Nix environment in the current shell
# shellcheck disable=SC1091
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

echo "Waiting for xcode-select to complete..."
until xcode-select --print-path &>/dev/null; do
    sleep 5
done

mkdir -p ~/Documents/GitHub/Infrastructure/

mkdir -p ~/.config/nix

git clone https://github.com/jnstockley/infrastructure.git ~/Documents/GitHub/Infrastructure/

ln -s ~/Documents/GitHub/Infrastructure/nix/macbook-pro/flake.nix ~/.config/nix/flake.nix
# ln -s ~/Documents/GitHub/Infrastructure/nix/macbook-pro/flake.lock ~/.config/nix/flake.lock

nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/nix#macbook --impure

#!/usr/bin/env bash

sudo xcode-select --install &>/dev/null

until xcode-select --print-path &>/dev/null; do
    sleep 5
done

mkdir -p ~/Documents/GitHub/Infrastructure/

mkdir -p ~/.config/nix

git clone https://github.com/jnstockley/infrastructure.git ~/Documents/GitHub/Infrastructure/

ln -s ~/Documents/GitHub/Infrastructure/nix/macbook-pro/flake.nix ~/.config/nix/flake.nix

# Download and install Nix
#sh <(curl -L https://nixos.org/nix/install) --daemon --yes

# Source the Nix environment in the current shell
#. /nix/var/nix/profiles/default/etc/profile\.d/nix-daemon\.sh

# nix flake init -t nix-darwin/master --extra-experimental-features "nix-command flakes"

nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/nix#macbook-pro --impure

#nix --extra-experimental-features "nix-command flakes" run nix-darwin/master#darwin-rebuild -- switch
darwin-rebuild switch --flake ~/.config/nix#macbook-pro

#!/usr/bin/env bash

sh <(curl -L https://nixos.org/nix/install)

# Download flake.nix file

nix --extra-experimental-features "nix-command flakes" run nix-darwin/master#darwin-rebuild -- switch

mkdir -p ~/.config/nix

curl -o ~/.config/nix/flake.nix https://raw.githubusercontent.com/jnstockley/infrastructure/refs/heads/main/nix/macbook-pro/flake.nix

darwin-rebuild switch

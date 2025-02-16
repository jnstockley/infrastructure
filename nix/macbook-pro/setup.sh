#!/usr/bin/env bash

sh <(curl -L https://nixos.org/nix/install)

# Download flake.nix file

nix --extra-experimental-features "nix-command flakes" run nix-darwin/master#darwin-rebuild -- switch

darwin-rebuild switch

mkdir -p ~/.config/nix


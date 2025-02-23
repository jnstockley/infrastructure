#!/usr/bin/env zsh

sudo xcode-select --install &> /dev/null

until xcode-select --print-path &> /dev/null; do
  sleep 5;
done

mkdir -p ~/Documents/GitHub/Infrastructure/

mkdir -p ~/.config/nix

git clone https://github.com/jnstockley/infrastructure.git ~/Documents/GitHub/Infrastructure/

ln -s ~/Documents/GitHub/Infrastructure/nix/macbook-pro/flake.nix ~/.config/nix/flake.nix

sh <(curl -L https://nixos.org/nix/install)

nix --extra-experimental-features "nix-command flakes" run nix-darwin/master#darwin-rebuild -- switch

darwin-rebuild switch

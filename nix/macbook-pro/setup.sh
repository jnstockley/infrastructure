#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

. "$SCRIPT_DIR/../scripts/xcode-cli-install.sh"

. "$SCRIPT_DIR/../scripts/rosetta-install.sh"

. "$SCRIPT_DIR/../scripts/nix-install.sh"
# Check if Nix is already installed
#if ! command -v nix &>/dev/null; then
#    # Download and install Nix
#    sh <(curl -L https://nixos.org/nix/install) --daemon --yes
#    # Source the Nix environment in the current shell
#    # shellcheck disable=SC1091
#    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
#fi

#mkdir -p ~/Documents/GitHub/Infrastructure/

#mkdir -p ~/.config/nix

# Check if GITHUB_TOKEN is set
if [ -n "$GITHUB_TOKEN" ]; then
  export NIX_CONFIG="access-tokens = github.com=${GITHUB_TOKEN}"
  . "$SCRIPT_DIR/../scripts/mas-disable.sh" "$SCRIPT_DIR/flake.nix"
  ln -s "$SCRIPT_DIR/*" ~/.config/
else # Not run in GitHub Actions
  if [ ! -d ~/Documents/GitHub/Infrastructure/.git ]; then
    echo "Infrastructure repo not found, cloning..."
    git clone https://github.com/jnstockley/infrastructure.git ~/Documents/GitHub/Infrastructure/
  else
    echo "Infrastructure repo found, pulling latest changes..."
    CURRENT_DIR=$(pwd)
    cd ~/Documents/GitHub/Infrastructure/ || exit
    git pull
    cd "$CURRENT_DIR" || exit
    ln -s ~/Documents/GitHub/Infrastructure/nix/macbook-pro/ ~/.config/
  fi
fi

sudo nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/macbook-pro#macbook --impure

exec "$SHELL"

## Check if GITHUB_ACTION is set and doesn't equals 1
#if [ "${GITHUB_ACTION}" != "1" ]; then
#    if [ ! -d ~/Documents/GitHub/Infrastructure/.git ]; then
#        git clone https://github.com/jnstockley/infrastructure.git ~/Documents/GitHub/Infrastructure/
#    else
#        cd ~/Documents/GitHub/Infrastructure/ || exit
#        git pull
#        cd ~
#    fi
#    if system_profiler SPHardwareDataType | grep -q "VirtualMac"; then
#        ../scripts/mas-disable.sh ~/Documents/GitHub/Infrastructure/nix/macbook-pro/flake.nix
#    fi
#else
#    sudo mkdir -p /var/root/nix
#
#    export NIX_CONF_DIR=/var/root/nix/nix.conf
#    rm -rf ~/Documents/GitHub/Infrastructure/
#    ln -s "$GITHUB_WORKSPACE" ~/Documents/GitHub
#
#    # Create or update the root nix.conf file with the GitHub token
#    if [ -n "$GITHUB_TOKEN" ]; then
#        echo "Adding GitHub token to root nix.conf..."
#
#        # Check if the file exists
#        if [ -f ~/.config/nix/nix.conf ]; then
#            # Check if access-tokens line already exists and update it
#            if grep -q "access-tokens" /var/root/nix/nix.conf; then
#                sudo sed -i '' "s|access-tokens.*|access-tokens = github.com=${GITHUB_TOKEN}|" /var/root/nix/nix.conf
#            else
#                # Append the access-tokens line
#                echo "access-tokens = github.com=${GITHUB_TOKEN}" | sudo tee -a /var/root/nix/nix.conf >/dev/null
#            fi
#        else
#            # Create the file with the access-tokens line
#            echo "access-tokens = github.com=${GITHUB_TOKEN}" | sudo tee /var/root/nix/nix.conf >/dev/null
#        fi
#    fi
#
#    find ~/Documents/GitHub/Infrastructure/ -name "*.nix" -type f -exec sed -i '' "s/jackstockley/$(whoami)/g" {} \;
#    ../scripts/mas-disable.sh ~/Documents/GitHub/Infrastructure/nix/macbook-pro/flake.nix
#fi

# Remove existing symlink if it exists
#if [ -L ~/.config/nix/flake.nix ]; then
#    rm ~/.config/nix/flake.nix
#fi

# Check if ~/.ssh.sh folder exists
#if [ ! -d ~/.ssh ]; then
#    mkdir ~/.ssh
#    chmod 700 ~/.ssh
#fi

#sudo chmod -R 755 /etc/nix/

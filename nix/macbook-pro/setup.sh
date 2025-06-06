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

# Check if Rosetta 2 is installed
if ! (arch -arch x86_64 uname -m >/dev/null); then
    echo "Rosetta 2 is not installed. Installing Rosetta 2…"
    # Installing Rosetta 2
    softwareupdate --install-rosetta --agree-to-license
else
    echo "Rosetta 2 is installed."
fi

# Check if Nix is already installed
if ! command -v nix &>/dev/null; then
    # Download and install Nix
    sh <(curl -L https://nixos.org/nix/install) --daemon --yes
    # Source the Nix environment in the current shell
    # shellcheck disable=SC1091
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

mkdir -p ~/Documents/GitHub/Infrastructure/

mkdir -p ~/.config/nix

# Check if GITHUB_ACTION is set and doesn't equals 1
if [ "${GITHUB_ACTION}" != "1" ]; then
    if [ ! -d ~/Documents/GitHub/Infrastructure/.git ]; then
        git clone https://github.com/jnstockley/infrastructure.git ~/Documents/GitHub/Infrastructure/
    else
        cd ~/Documents/GitHub/Infrastructure/ || exit
        git pull
        cd ~
    fi
    if system_profiler SPHardwareDataType | grep -q "VirtualMac"; then
        sed -i '' '/masApps = {/,/};/d' ~/Documents/GitHub/Infrastructure/nix/macbook-pro/flake.nix
    fi
else
    sudo mkdir -p /var/root/nix

    export NIX_CONF_DIR=/var/root/nix/nix.conf
    rm -rf ~/Documents/GitHub/Infrastructure/
    ln -s "$GITHUB_WORKSPACE" ~/Documents/GitHub

    # Create or update the root nix.conf file with the GitHub token
    if [ -n "$GITHUB_TOKEN" ]; then
        echo "Adding GitHub token to root nix.conf..."

        # Check if the file exists
        if [ -f ~/.config/nix/nix.conf ]; then
            # Check if access-tokens line already exists and update it
            if grep -q "access-tokens" /var/root/nix/nix.conf; then
                sudo sed -i '' "s|access-tokens.*|access-tokens = github.com=${GITHUB_TOKEN}|" /var/root/nix/nix.conf
            else
                # Append the access-tokens line
                echo "access-tokens = github.com=${GITHUB_TOKEN}" | sudo tee -a /var/root/nix/nix.conf >/dev/null
            fi
        else
            # Create the file with the access-tokens line
            echo "access-tokens = github.com=${GITHUB_TOKEN}" | sudo tee /var/root/nix/nix.conf >/dev/null
        fi
    fi

    find ~/Documents/GitHub/Infrastructure/ -name "*.nix" -type f -exec sed -i '' "s/jackstockley/$(whoami)/g" {} \;
    sed -i '' '/masApps = {/,/};/d' ~/Documents/GitHub/Infrastructure/nix/macbook-pro/flake.nix
fi

# Remove existing symlink if it exists
if [ -L ~/.config/nix/flake.nix ]; then
    rm ~/.config/nix/flake.nix
fi

# Check if ~/.ssh.sh folder exists
if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh
    chmod 700 ~/.ssh
fi

ln -s ~/Documents/GitHub/Infrastructure/nix/macbook-pro/ ~/.config/

sudo chmod -R 755 /etc/nix/

sudo nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/macbook-pro#macbook --impure

exec "$SHELL"

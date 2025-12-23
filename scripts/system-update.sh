#!/usr/bin/env bash

set -e # Exit on error

# Function to check if running as root or with sudo
check_sudo() {
    if [ "$EUID" -ne 0 ]; then
        echo "This script must be run with sudo or as root"
        exit 1
    fi
}

# Function to check if apt is available
check_apt() {
    if ! command -v apt-get &>/dev/null; then
        echo "Error: apt-get is not available on this system"
        echo "This script is designed for Debian/Ubuntu-based distributions"
        exit 1
    fi
}

# Function to detect distribution
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "Detected distribution: $NAME $VERSION"

        # Check if it's a Debian-based distro
        if [[ ! "$ID_LIKE" =~ "debian" ]] && [[ "$ID" != "debian" ]] && [[ "$ID" != "ubuntu" ]]; then
            echo "Warning: This may not be a Debian-based distribution"
            read -p "Continue anyway? (y/N): " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                exit 1
            fi
        fi
    else
        echo "Warning: Cannot detect distribution"
    fi
}

# Main execution
main() {
    echo "=== System Update Script ==="
    echo

    detect_distro
    check_apt
    check_sudo

    echo
    echo "Starting system update..."
    echo

    echo ">>> Running apt-get update..."
    apt-get update -y

    echo
    echo ">>> Running apt-get upgrade..."
    apt-get upgrade -y

    echo
    echo ">>> Running apt-get dist-upgrade..."
    apt-get dist-upgrade -y

    echo
    echo ">>> Running apt-get autoremove..."
    apt-get autoremove -y

    echo
    echo ">>> Running apt-get clean..."
    apt-get clean

    echo
    echo "=== System update completed successfully ==="
}

main "$@"

#!/usr/bin/env bash
set -euo pipefail

if [[ $# -eq 0 ]]; then
    echo "Usage: $0 HOST [HOST ...]" >&2
    exit 2
fi

# AdGuard is published on the photo server's LAN address, reachable over wg0.
# Route private domains explicitly instead of racing the runner's public DNS.
sudo resolvectl dns wg0 192.168.1.135
sudo resolvectl domain wg0 '~local.jstockley.com' '~internal.jstockley.com'
sudo resolvectl default-route wg0 no
# Both libc (SSH) and Go (OpenTofu providers) must use systemd-resolved.
sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
sudo resolvectl flush-caches

for host in "$@"; do
    resolved=false
    for attempt in {1..10}; do
        if timeout 5 getent ahosts "$host" >/dev/null; then
            resolved=true
            break
        fi
        echo "Waiting for VPN DNS ($attempt/10)..."
        if [[ $attempt -lt 10 ]]; then
            sleep 2
        fi
    done

    if [[ $resolved != true ]]; then
        echo "Unable to resolve $host through VPN DNS." >&2
        sudo resolvectl status wg0 >&2 || true
        exit 1
    fi
done

echo "VPN DNS resolved all required hosts."

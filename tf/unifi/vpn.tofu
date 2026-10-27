# Ports are inferred from the controller's built-in "Allow WireGuard VPNs" rule (51820, 51821).
# Verify with `tofu plan` after the import; the controller API doesn't expose them to me.
# private_key is left unset so the provider doesn't overwrite the server's existing key on import.

resource "unifi_vpn_server" "wireguard_server_1" {
  name    = "WireGuard Server 1"
  subnet  = "192.168.3.1/24"
  enabled = true

  wireguard = {
    port = 51820
  }

  dns = {
    servers = [
      "192.168.1.135",
      "1.1.1.1"
    ]
  }
}

resource "unifi_vpn_server" "one_click_vpn" {
  name    = "One-Click VPN"
  subnet  = "192.168.7.1/24"
  enabled = true

  wireguard = {
    port = 51821
  }
}

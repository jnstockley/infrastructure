data "tailscale_device" "arcane-agent-racknerd" {
  hostname = "arcane-agent-racknerd"
  wait_for = "60s"
}

data "tailscale_device" "arcane-manager-photo-server" {
  hostname = "arcane-manager-photo-server"
  wait_for = "60s"
}
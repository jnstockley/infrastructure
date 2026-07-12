resource "tailscale_device_tags" "arcane_agent_tags" {
  device_id = data.tailscale_device.arcane-agent-racknerd.node_id
  tags      = ["tag:arcane-agent", "tag:racknerd", "tag:docker"]
}

resource "tailscale_device_tags" "arcane_manager_tags" {
  device_id = data.tailscale_device.arcane-manager-photo-server.node_id
  tags      = ["tag:arcane-manager", "tag:photo-server", "tag:docker"]
}

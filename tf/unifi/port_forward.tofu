locals {
  photo_server_ip = "192.168.1.135"
}

resource "unifi_port_forward" "http" {
  name     = "HTTP"
  protocol = "tcp_udp"

  wan = {
    interface  = "wan"
    ip_address = "any"
    port       = "80,443"
  }

  forward = {
    ip   = local.photo_server_ip
    port = "80,443"
  }
}

resource "unifi_port_forward" "dot" {
  name     = "DoT"
  protocol = "tcp_udp"

  wan = {
    interface  = "wan"
    ip_address = "any"
    port       = "853"
  }

  forward = {
    ip   = local.photo_server_ip
    port = "853"
  }
}

# Name matches the controller (typo included) so there's no rename diff
resource "unifi_port_forward" "wireguard" {
  name     = "WiregGuard"
  protocol = "udp"

  wan = {
    interface  = "wan"
    ip_address = "any"
    port       = "51822"
  }

  forward = {
    ip   = local.photo_server_ip
    port = "51822"
  }
}

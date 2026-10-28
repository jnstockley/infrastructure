# Built-in zones (Internal, External, ...) are controller defaults, so they are looked up, not managed.
data "unifi_firewall_zone" "internal" {
  name = "Internal"
}

data "unifi_firewall_zone" "external" {
  name = "External"
}

resource "unifi_firewall_zone" "iot" {
  name = "IoT"
  network_ids = [
    unifi_network.iot.id
  ]
}

# Policy order (index) can't be managed by the provider. All of these sit at index 10000 in their zone pair.

resource "unifi_firewall_policy" "block_internet" {
  name                 = "Block Internet"
  action               = "BLOCK"
  protocol             = "all"
  ip_version           = "BOTH"
  create_allow_respond = false

  source = {
    zone_id         = data.unifi_firewall_zone.internal.id
    matching_target = "CLIENT"
    client_macs     = [unifi_client.air_quality_monitor.mac, unifi_client.lg_tv.mac]
  }

  destination = {
    zone_id         = data.unifi_firewall_zone.external.id
    matching_target = "ANY"
  }
}

resource "unifi_firewall_policy" "allow_internal" {
  name                 = "Allow Internal"
  action               = "ALLOW"
  protocol             = "all"
  ip_version           = "BOTH"
  create_allow_respond = true

  source = {
    zone_id         = data.unifi_firewall_zone.internal.id
    matching_target = "ANY"
  }

  destination = {
    zone_id         = unifi_firewall_zone.iot.id
    matching_target = "ANY"
  }
}

# Lets the DNS server (on the IoT zone side) resolve upstream
resource "unifi_firewall_policy" "iot_dns" {
  name                 = "IoT DNS"
  action               = "ALLOW"
  protocol             = "all"
  ip_version           = "BOTH"
  create_allow_respond = false

  source = {
    zone_id            = unifi_firewall_zone.iot.id
    matching_target    = "CLIENT"
    client_macs        = [unifi_client.photo_server.mac]
    port               = "53"
    port_matching_type = "SPECIFIC"
  }

  destination = {
    zone_id         = data.unifi_firewall_zone.external.id
    matching_target = "ANY"
  }
}

# Inbound WireGuard over IPv6 (the IPv4 side is the port forward in port_forward.tofu)
resource "unifi_firewall_policy" "wireguard_ipv6" {
  name                 = "WG-IPv6"
  action               = "ALLOW"
  protocol             = "udp"
  ip_version           = "IPV6"
  create_allow_respond = true

  source = {
    zone_id         = data.unifi_firewall_zone.external.id
    matching_target = "ANY"
  }

  destination = {
    zone_id            = data.unifi_firewall_zone.internal.id
    matching_target    = "IP"
    ips                = ["2604:2e8b:9ca3:0:be24:11ff:fec1:69d7"]
    port               = "51822"
    port_matching_type = "SPECIFIC"
  }
}

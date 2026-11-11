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

# Candidate AirPlay exception: this HTTP request was observed during the
# successful test. Keep it above Block Internet in the IoT -> External table.
resource "unifi_firewall_policy" "lg_tv_online_check" {
  name                  = "LG TV Online Check"
  action                = "ALLOW"
  enabled               = true
  protocol              = "tcp"
  ip_version            = "BOTH"
  connection_state_type = "ALL"
  # UniFi rejects auto-return rules for WEB matches; External return traffic
  # is already allowed by the built-in established/related policy.
  create_allow_respond = false
  logging              = true

  source = {
    zone_id            = unifi_firewall_zone.iot.id
    matching_target    = "CLIENT"
    client_macs        = [unifi_client.lg_tv.mac]
    port_matching_type = "ANY"
  }

  destination = {
    zone_id            = data.unifi_firewall_zone.external.id
    matching_target    = "WEB"
    web_domains        = ["lgtvonline.lge.com"]
    port               = "80"
    port_matching_type = "SPECIFIC"
  }
}

# Direct-IP test for the LG online-status endpoint, limited to HTTP from the TV.
# Keep this above Block Internet in the IoT -> External policy table.
resource "unifi_firewall_policy" "lg_tv_online_check_ip" {
  name                  = "LG TV Online Check IP"
  action                = "ALLOW"
  enabled               = true
  protocol              = "tcp"
  ip_version            = "IPV4"
  connection_state_type = "ALL"
  create_allow_respond  = false
  logging               = true

  source = {
    zone_id            = unifi_firewall_zone.iot.id
    matching_target    = "CLIENT"
    client_macs        = [unifi_client.lg_tv.mac]
    port_matching_type = "ANY"
  }

  destination = {
    zone_id            = data.unifi_firewall_zone.external.id
    matching_target    = "IP"
    ips                = ["35.81.131.123"]
    port               = "80"
    port_matching_type = "SPECIFIC"
  }
}

# Keep this TV-only exception above Block Internet in the IoT -> External table.
resource "unifi_firewall_policy" "lg_tv_airplay_check" {
  name                  = "LG TV AirPlay Check"
  action                = "ALLOW"
  enabled               = true
  protocol              = "tcp"
  ip_version            = "IPV4"
  connection_state_type = "ALL"
  create_allow_respond  = false
  logging               = true

  source = {
    zone_id            = unifi_firewall_zone.iot.id
    matching_target    = "CLIENT"
    client_macs        = [unifi_client.lg_tv.mac]
    port_matching_type = "ANY"
  }

  destination = {
    zone_id            = data.unifi_firewall_zone.external.id
    matching_target    = "IP"
    ips                = ["173.233.81.237"]
    port               = "4437"
    port_matching_type = "SPECIFIC"
  }
}

# Allow the TV's advertised public DNS resolvers without granting other egress.
# Keep this above Block Internet in the IoT -> External policy table.
resource "unifi_firewall_policy" "lg_tv_external_dns" {
  name                  = "LG TV External DNS"
  action                = "ALLOW"
  enabled               = true
  protocol              = "tcp_udp"
  ip_version            = "IPV4"
  connection_state_type = "ALL"
  create_allow_respond  = false
  logging               = true

  source = {
    zone_id            = unifi_firewall_zone.iot.id
    matching_target    = "CLIENT"
    client_macs        = [unifi_client.lg_tv.mac]
    port_matching_type = "ANY"
  }

  destination = {
    zone_id            = data.unifi_firewall_zone.external.id
    matching_target    = "IP"
    ips                = ["1.1.1.2", "1.0.0.2"]
    port               = "53"
    port_matching_type = "SPECIFIC"
  }
}

resource "unifi_firewall_policy" "block_internet" {
  name                 = "Block Internet"
  action               = "BLOCK"
  protocol             = "all"
  ip_version           = "BOTH"
  create_allow_respond = false

  source = {
    zone_id         = unifi_firewall_zone.iot.id
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

# Allow IoT clients to query AdGuard on the Internal photo server.
# In the IoT -> Internal policy table, keep this exception above Block IoT to Internal.
resource "unifi_firewall_policy" "iot_dns" {
  name                  = "IoT DNS"
  action                = "ALLOW"
  enabled               = true
  protocol              = "tcp_udp"
  ip_version            = "BOTH"
  connection_state_type = "ALL"
  create_allow_respond  = true

  source = {
    zone_id         = unifi_firewall_zone.iot.id
    matching_target = "ANY"
    # Omitted endpoint fields retain imported values in provider v0.65.0.
    port_matching_type = "ANY"
  }

  destination = {
    zone_id            = data.unifi_firewall_zone.internal.id
    matching_target    = "IP"
    ips                = [unifi_client.photo_server.fixed_ip]
    port               = "53"
    port_matching_type = "SPECIFIC"
  }
}

# AirPlay negotiates high UDP ports on the sender. Allow the TV to reach any
# Internal sender without pinning that sender's address or device identity.
# Keep this above Block IoT to Internal in the IoT -> Internal policy table.
resource "unifi_firewall_policy" "lg_tv_airplay_internal" {
  name                  = "LG TV AirPlay Internal"
  action                = "ALLOW"
  enabled               = true
  protocol              = "udp"
  ip_version            = "BOTH"
  connection_state_type = "ALL"
  # The existing Allow Internal policy already permits traffic to the TV.
  create_allow_respond = false
  logging              = true

  source = {
    zone_id            = unifi_firewall_zone.iot.id
    matching_target    = "CLIENT"
    client_macs        = [unifi_client.lg_tv.mac]
    port_matching_type = "ANY"
  }

  destination = {
    zone_id            = data.unifi_firewall_zone.internal.id
    matching_target    = "ANY"
    port               = "49152-65535"
    port_matching_type = "SPECIFIC"
  }
}

# Block IoT-initiated traffic, while leaving established/related replies to
# Internal-initiated connections to the return rule from Allow Internal.
resource "unifi_firewall_policy" "block_iot_internal" {
  name                  = "Block IoT to Internal"
  action                = "BLOCK"
  enabled               = true
  protocol              = "all"
  ip_version            = "BOTH"
  connection_state_type = "CUSTOM"
  connection_states     = ["NEW", "INVALID"]
  create_allow_respond  = false

  # Sequence initial operations after the exception, but this does not enforce
  # policy evaluation order; that must be checked in the UniFi policy table.
  depends_on = [
    unifi_firewall_policy.iot_dns,
    unifi_firewall_policy.allow_internal,
    unifi_firewall_policy.lg_tv_airplay_internal,
  ]

  source = {
    zone_id         = unifi_firewall_zone.iot.id
    matching_target = "ANY"
  }

  destination = {
    zone_id         = data.unifi_firewall_zone.internal.id
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

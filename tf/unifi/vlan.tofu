resource "unifi_network" "default" {
  name   = "Default"
  subnet = "192.168.1.1/24"

  dhcp_server = {
    enabled     = true
    dns_enabled = true
    dns_servers = [
      "192.168.1.135",
      "1.1.1.2",
      "1.0.0.2"
    ]
    start = "192.168.1.6"
    stop  = "192.168.1.254"
  }

  ipv6_interface_type = "pd"
  ipv6_pd_interface   = "wan"
  setting_preference  = "manual"
}

resource "unifi_network" "iot" {
  name               = "IoT"
  subnet             = "192.168.2.1/24"
  vlan               = 2
  internet_access    = false
  lte_lan            = false
  setting_preference = "manual"

  dhcp_server = {
    enabled = true
    start   = "192.168.2.6"
    stop    = "192.168.2.254"
  }
}

resource "adguard_rewrite" "home_server_ipv4" {
  domain = "home.internal.jstockley.com"
  answer = "192.168.1.119"
}

resource "adguard_rewrite" "photo_server_ipv4" {
  domain = "photo-server.internal.jstockley.com"
  answer = "192.168.1.135"
}

resource "adguard_rewrite" "photo_server_ipv6" {
  domain = adguard_rewrite.photo_server_ipv4.domain
  answer = "2604:2e8b:8077:0:be24:11ff:fec1:69d7"
}

resource "adguard_rewrite" "backup_server_ipv4" {
  domain = "backup-server.internal.jstockley.com"
  answer = "192.168.1.111"
}

resource "adguard_rewrite" "proxmox_server_ipv4" {
  domain = "proxmox-server.internal.jstockley.com"
  answer = "192.168.1.18"
}

resource "adguard_rewrite" "local_wildcard_ipv4" {
  domain = "*.local.jstockley.com"
  answer = adguard_rewrite.photo_server_ipv4.answer
}

resource "adguard_rewrite" "local_wildcard_ipv6" {
  domain = adguard_rewrite.local_wildcard_ipv4.domain
  answer = adguard_rewrite.photo_server_ipv6.answer
}

output "local_wildcard" {
  value = trimprefix(adguard_rewrite.local_wildcard_ipv4.domain, "*.")
}

output "host_records" {
  description = "Managed internal hostnames and IPv4 addresses for state consumers."
  value = {
    home_server = {
      hostname = adguard_rewrite.home_server_ipv4.domain
      ipv4     = adguard_rewrite.home_server_ipv4.answer
    }
    photo_server = {
      hostname = adguard_rewrite.photo_server_ipv4.domain
      ipv4     = adguard_rewrite.photo_server_ipv4.answer
    }
    backup_server = {
      hostname = adguard_rewrite.backup_server_ipv4.domain
      ipv4     = adguard_rewrite.backup_server_ipv4.answer
    }
    proxmox_server = {
      hostname = adguard_rewrite.proxmox_server_ipv4.domain
      ipv4     = adguard_rewrite.proxmox_server_ipv4.answer
    }
  }
}

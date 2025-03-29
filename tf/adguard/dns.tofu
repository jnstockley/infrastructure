# manage a DNS rewrite rule
resource "adguard_rewrite" "proxmox" {
  domain = "proxmox-server.internal.jstockley.com"
  answer = "192.168.0.18"
}

# manage a DNS rewrite rule
resource "adguard_rewrite" "photo-server" {
  domain = "photo-server.internal.jstockley.com"
  answer = "192.168.0.105"
}

# manage a DNS rewrite rule
resource "adguard_rewrite" "backup-server" {
  domain = "backup-server.internal.jstockley.com"
  answer = "192.168.0.102"
}

# manage a DNS rewrite rule
resource "adguard_rewrite" "iowa-home-internal" {
  domain = "iowa-home.internal.jstockley.com"
  answer = "192.168.0.107"
}

# manage a DNS rewrite rule
resource "adguard_rewrite" "wildcard" {
  domain = "*.local.jstockley.com"
  answer = "192.168.0.105"
}

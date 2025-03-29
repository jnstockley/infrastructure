resource "cloudflare_dns_record" "vpn" {
  zone_id = var.cloudflare_zone_id
  content = "172.245.131.22"
  name    = "vpn.jstockley.com"
  proxied = false
  comment = "Last updated by Terraform"
  ttl     = 1
  type    = "A"
}

resource "cloudflare_dns_record" "chicago-vpn" {
  zone_id = var.cloudflare_zone_id
  content = "8.8.8.8"
  name    = "chicago.vpn.jstockley.com"
  proxied = false
  comment = "Last updated by Terraform"
  ttl     = 1
  type    = "A"
}
resource "cloudflare_dns_record" "iowa-vpn" {
  zone_id = var.cloudflare_zone_id
  content = "8.8.8.8"
  name    = "iowa.vpn.jstockley.com"
  proxied = false
  comment = "Last updated by Terraform"
  ttl     = 1
  type    = "A"
}
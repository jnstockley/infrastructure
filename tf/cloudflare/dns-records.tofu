resource "cloudflare_dns_record" "vpn" {
  zone_id = var.cloudflare_zone_id
  content = jsondecode(data.http.racknerd_ip.response_body).ipv4_address
  name    = "vpn.jstockley.com"
  proxied = false
  comment = "Last updated by Terraform"
  ttl     = 300
  type    = "A"
}

resource "cloudflare_dns_record" "chicago-vpn" {
  zone_id = var.cloudflare_zone_id
  content = jsondecode(data.http.chicago_ip.response_body).ipv4_address
  name    = "chicago.vpn.jstockley.com"
  proxied = false
  comment = "Last updated by Terraform"
  ttl     = 300
  type    = "A"
}

resource "cloudflare_dns_record" "iowa-vpn" {
  zone_id = var.cloudflare_zone_id
  content = jsondecode(data.http.iowa_ip.response_body).ipv4_address
  name    = "iowa.vpn.jstockley.com"
  proxied = false
  comment = "Last updated by Terraform"
  ttl     = 300
  type    = "A"
}

resource "cloudflare_dns_record" "airflow" {
  name    = "airflow.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = cloudflare_dns_record.vpn.name
  proxied = true
}

resource "cloudflare_dns_record" "api" {
  name    = "api.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = cloudflare_dns_record.vpn.name
  proxied = true
}

resource "cloudflare_dns_record" "backup" {
  name    = "backup.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = cloudflare_dns_record.vpn.name
  proxied = true
}

resource "cloudflare_dns_record" "databasus" {
  name    = "databasus.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = cloudflare_dns_record.vpn.name
  proxied = true
}

resource "cloudflare_dns_record" "dns" {
  name    = "dns.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = cloudflare_dns_record.iowa-vpn.name
  proxied = true
}

resource "cloudflare_dns_record" "git" {
  name    = "git.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = cloudflare_dns_record.iowa-vpn.name
  proxied = true
}

resource "cloudflare_dns_record" "home" {
  name    = "home.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = cloudflare_dns_record.iowa-vpn.name
  proxied = true
}

resource "cloudflare_dns_record" "idp" {
  name    = "idp.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = cloudflare_dns_record.iowa-vpn.name
  proxied = true
}

resource "cloudflare_dns_record" "website_ipv4_1" {
  name    = "jstockley.com"
  ttl     = 1
  type    = "A"
  zone_id = var.cloudflare_zone_id
  content = "185.199.110.153"
  proxied = false
}

resource "cloudflare_dns_record" "website_ipv4_2" {
  name    = "jstockley.com"
  ttl     = 1
  type    = "A"
  zone_id = var.cloudflare_zone_id
  content = "185.199.111.153"
  proxied = false
}

resource "cloudflare_dns_record" "website_ipv4_3" {
  name    = "jstockley.com"
  ttl     = 1
  type    = "A"
  zone_id = var.cloudflare_zone_id
  content = "185.199.109.153"
  proxied = false
}

resource "cloudflare_dns_record" "website_ipv4_4" {
  name    = "jstockley.com"
  ttl     = 1
  type    = "A"
  zone_id = var.cloudflare_zone_id
  content = "185.199.108.153"
  proxied = false
}

resource "cloudflare_dns_record" "website_ipv6_1" {
  name    = "jstockley.com"
  ttl     = 1
  type    = "AAAA"
  zone_id = var.cloudflare_zone_id
  content = "2606:50c0:8003::153"
  proxied = false
}

resource "cloudflare_dns_record" "website_ipv6_2" {
  name    = "jstockley.com"
  ttl     = 1
  type    = "AAAA"
  zone_id = var.cloudflare_zone_id
  content = "2606:50c0:8002::153"
  proxied = false
}

resource "cloudflare_dns_record" "website_ipv6_3" {
  name    = "jstockley.com"
  ttl     = 1
  type    = "AAAA"
  zone_id = var.cloudflare_zone_id
  content = "2606:50c0:8001::153"
  proxied = false
}

resource "cloudflare_dns_record" "website_ipv6_4" {
  name    = "jstockley.com"
  ttl     = 1
  type    = "AAAA"
  zone_id = var.cloudflare_zone_id
  content = "2606:50c0:8000::153"
  proxied = false
}

resource "cloudflare_dns_record" "mc" {
  name    = "mc.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = cloudflare_dns_record.iowa-vpn.name
  proxied = true
}

resource "cloudflare_dns_record" "mend" {
  name    = "mend.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = cloudflare_dns_record.iowa-vpn.name
  proxied = true
}

resource "cloudflare_dns_record" "nextcloud" {
  name    = "nextcloud.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = cloudflare_dns_record.iowa-vpn.name
  proxied = true
}

resource "cloudflare_dns_record" "open-speedtest" {
  name    = "speed.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = cloudflare_dns_record.iowa-vpn.name
  proxied = true
}

resource "cloudflare_dns_record" "pgadmin" {
  name    = "pgadmin.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = cloudflare_dns_record.vpn.name
  proxied = false
}

resource "cloudflare_dns_record" "phpymyadmin" {
  name    = "phpmyadmin.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = cloudflare_dns_record.vpn.name
  proxied = true
}

resource "cloudflare_dns_record" "photos" {
  name    = "photos.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = cloudflare_dns_record.iowa-vpn.name
  proxied = false
}

resource "cloudflare_dns_record" "pikvm" {
  name    = "pikvm.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = cloudflare_dns_record.iowa-vpn.name
  proxied = true
}

resource "cloudflare_dns_record" "play" {
  name    = "play.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = cloudflare_dns_record.iowa-vpn.name
  proxied = false
}

resource "cloudflare_dns_record" "n8n" {
  name    = "n8n.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = cloudflare_dns_record.iowa-vpn.name
  proxied = false
}

resource "cloudflare_dns_record" "dkim" {
  name    = "sig1._domainkey"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = "sig1.dkim.jstockley.com.at.icloudmailadmin.com"
  proxied = false
}

resource "cloudflare_dns_record" "secrets" {
  name    = "secrets.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = cloudflare_dns_record.iowa-vpn.name
  proxied = true
}

resource "cloudflare_dns_record" "status" {
  name    = "status.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = cloudflare_dns_record.vpn.name
  proxied = true
}

resource "cloudflare_dns_record" "synology" {
  name    = "nas.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = cloudflare_dns_record.iowa-vpn.name
  proxied = true
}

resource "cloudflare_dns_record" "traefik" {
  name    = "traefik.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = "${cloudflare_zero_trust_tunnel_cloudflared.racknerd.id}.cfargotunnel.com"
  proxied = true
}

resource "cloudflare_dns_record" "vault" {
  name    = "vault.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = cloudflare_dns_record.iowa-vpn.name
  proxied = true
}

resource "cloudflare_dns_record" "www" {
  name    = "www.jstockley.com"
  ttl     = 1
  type    = "CNAME"
  zone_id = var.cloudflare_zone_id
  content = "jnstockley.github.io"
  proxied = true
}

resource "cloudflare_dns_record" "mail" {
  name     = "jstockley.com"
  ttl      = 1
  type     = "MX"
  zone_id  = var.cloudflare_zone_id
  content  = "mx01.mail.icloud.com"
  proxied  = false
  priority = 10
}

resource "cloudflare_dns_record" "mail_2" {
  name     = "jstockley.com"
  ttl      = 1
  type     = "MX"
  zone_id  = var.cloudflare_zone_id
  content  = "mx02.mail.icloud.com"
  proxied  = false
  priority = 10
}

resource "cloudflare_dns_record" "dmarc" {
  name    = "_dmarc"
  ttl     = 1
  type    = "TXT"
  zone_id = var.cloudflare_zone_id
  content = "\"v=DMARC1; p=reject; rua=mailto:28085d89f45a469f898053cb715922b0@dmarc-reports.cloudflare.net\""
  proxied = false
}

resource "cloudflare_dns_record" "have-i-been-pwned" {
  name    = "jstockley.com"
  ttl     = 1
  type    = "TXT"
  zone_id = var.cloudflare_zone_id
  content = "\"have-i-been-pwned-verification=4126fff6018ddef349ab9319d415a68f\""
  proxied = false
}

resource "cloudflare_dns_record" "apple-domain-verification" {
  name    = "jstockley.com"
  ttl     = 1
  type    = "TXT"
  zone_id = var.cloudflare_zone_id
  content = "\"apple-domain=HKHZ7tmeiNIBwf3k\""
  proxied = false
}

resource "cloudflare_dns_record" "spf" {
  name    = "jstockley.com"
  ttl     = 1
  type    = "TXT"
  zone_id = var.cloudflare_zone_id
  content = "\"v=spf1 include:icloud.com -all\""
  proxied = false
}

output "vpn_dns_record_name" {
  value = cloudflare_dns_record.vpn.name
}

output "chicago_vpn_dns_record_name" {
  value = cloudflare_dns_record.chicago-vpn.name
}

output "iowa_vpn_dns_record_name" {
  value = cloudflare_dns_record.iowa-vpn.name
}

output "airflow_dns_record_name" {
  value = cloudflare_dns_record.airflow.name
}

output "api_dns_record_name" {
  value = cloudflare_dns_record.api.name
}

output "backup_dns_record_name" {
  value = cloudflare_dns_record.backup.name
}

output "databasus_dns_record_name" {
  value = cloudflare_dns_record.databasus.name
}

output "adguard_dns_record_name" {
  value = cloudflare_dns_record.dns.name
}

output "forgejo_dns_record_name" {
  value = cloudflare_dns_record.git.name
}

output "home_dns_record_name" {
  value = cloudflare_dns_record.home.name
}

output "authentik_dns_record_name" {
  value = cloudflare_dns_record.idp.name
}

output "website_dns_record_name" {
  value = cloudflare_dns_record.website_ipv4_1.name
}

output "minecraft_dns_record_name" {
  value = cloudflare_dns_record.mc.name
}

output "mend_dns_record_name" {
  value = cloudflare_dns_record.mend.name
}

output "nextcloud_dns_record_name" {
  value = cloudflare_dns_record.nextcloud.name
}

output "open_speedtest_dns_record_name" {
  value = cloudflare_dns_record.open-speedtest.name
}

output "pgadmin_dns_record_name" {
  value = cloudflare_dns_record.pgadmin.name
}

output "phpmyadmin_dns_record_name" {
  value = cloudflare_dns_record.phpymyadmin.name
}

output "photos_dns_record_name" {
  value = cloudflare_dns_record.photos.name
}

output "pikvm_dns_record_name" {
  value = cloudflare_dns_record.pikvm.name
}

output "play_dns_record_name" {
  value = cloudflare_dns_record.play.name
}

output "n8n_dns_record_name" {
  value = cloudflare_dns_record.n8n.name
}

output "secrets_dns_record_name" {
  value = cloudflare_dns_record.secrets.name
}

output "status_dns_record_name" {
  value = cloudflare_dns_record.status.name
}

output "synology_dns_record_name" {
  value = cloudflare_dns_record.synology.name
}

output "traefik_dns_record_name" {
  value = cloudflare_dns_record.traefik.name
}

output "vault_dns_record_name" {
  value = cloudflare_dns_record.vault.name
}

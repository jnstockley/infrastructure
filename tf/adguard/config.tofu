resource "adguard_config" "config" {
  filtering = {
    update_interval = 1
  }

  querylog = {
    enabled  = true
    interval = 720
  }

  stats = {
    enabled  = true
    interval = 168
  }

  dns = {
    upstream_dns    = ["https://security.cloudflare-dns.com/dns-query"]
    dnssec_enabled  = true
    fallback_dns    = ["1.1.1.2", "1.0.0.2"]
    edns_cs_enabled = true
  }

  tls = {
    enabled           = true
    server_name       = var.adguard_host
    certificate_chain = var.adguard_cert_chain
    private_key       = var.adguard_private_key
  }
}

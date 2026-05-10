resource "adguard_config" "config" {


  filtering = {
    enabled         = true
    update_interval = 1
  }

  dhcp = {
    enabled = false
  }

  dns = {
    disallowed_clients = [
      "178.131.146.199",
      "5.125.44.24",
      "5.126.102.74",
      "65.49.1.31",
      "8.217.254.174",
      "91.92.129.200",
    ]
    dnssec_enabled  = true
    edns_cs_enabled = true
    fallback_dns = [
      "1.1.1.2",
      "2606:4700:4700::1112",
      "1.0.0.2",
      "2606:4700:4700::1002",
    ]
    upstream_dns = [
      "https://security.cloudflare-dns.com/dns-query",
    ]
  }
  safebrowsing = false
  safesearch = {
    enabled = false
  }

  querylog = {
    interval = 720
  }

  stats = {
    interval = 168
  }

  tls = {
    certificate_chain = ""
    enabled           = true
    private_key       = ""
    server_name       = "dns.jstockley.com"
  }
}
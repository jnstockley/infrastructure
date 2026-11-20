resource "adguard_config" "config" {
  filtering = {
    enabled         = true
    update_interval = 1
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

  # Traefik issues/renews the certificate; its exporter shares only this
  # domain's PEM files with AdGuard. These are paths inside the container,
  # not file() reads on the OpenTofu runner. Deploy the mounts/exporter first.
  tls = {
    certificate_chain  = "/opt/adguardhome/certs/cert.pem"
    enabled            = true
    force_https        = false
    port_https         = 443
    port_dns_over_tls  = 0
    port_dns_over_quic = 0
    private_key        = "/opt/adguardhome/certs/key.pem"
    serve_plain_dns    = true
    server_name        = data.terraform_remote_state.cloudflare.outputs.adguard_dns_record_name
  }

  lifecycle {
    # The API returns [] for an unset allowlist; provider validation rejects [].
    # Keep managing disallowed_clients while suppressing this normalization diff.
    ignore_changes = [dns.allowed_clients]
  }
}

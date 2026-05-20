resource "cloudflare_zero_trust_tunnel_cloudflared" "racknerd" {
  account_id = var.cloudflare_account_id
  name       = "racknerd"
  config_src = "cloudflare"
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "racknerd-config" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.racknerd.id
  config = {
    ingress = [
      {
        hostname = cloudflare_dns_record.traefik.name
        path     = "/ping"
        service  = "http://traefik:8082"
      },
      {
        hostname = cloudflare_dns_record.traefik.name
        service  = "http://traefik:8080"
      },
      {
        service = "http_status:404"
      }
    ]
  }
}

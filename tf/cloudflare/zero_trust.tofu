resource "cloudflare_zero_trust_access_identity_provider" "authentik" {
  account_id = var.cloudflare_account_id
  config = {
    auth_url  = "https://${cloudflare_dns_record.idp.name}/application/o/authorize/"
    certs_url = "https://${cloudflare_dns_record.idp.name}/application/o/cloudflare/jwks/"
    claims = [
      "name",
      "nickname",
      "groups",
      "email_verified"
    ]
    client_id        = data.terraform_remote_state.authentik.outputs.authentik_cloudflare_client_id
    client_secret    = data.terraform_remote_state.authentik.outputs.authentik_cloudflare_client_secret
    email_claim_name = "email"
    scopes = [
      "openid",
      "email",
      "profile"
    ]
    token_url = "https://${cloudflare_dns_record.idp.name}/application/o/token/"
  }
  name = "Authentik"
  type = "oidc"
}

resource "cloudflare_zero_trust_access_policy" "internal_ips" {
  account_id       = var.cloudflare_account_id
  name             = "Bypass Internal IPs"
  session_duration = "24h"
  decision         = "bypass"
  include = [
    {
      ip = {
        ip = "${jsondecode(data.http.iowa_ip.response_body).ipv4_address}/32"
      }
    },
    {
      ip = {
        ip = "${jsondecode(data.http.racknerd_ip.response_body).ipv4_address}/32" # Racknerd IP
      }
  }]
}

resource "cloudflare_zero_trust_access_policy" "internal_ips-v6" {
  account_id       = var.cloudflare_account_id
  name             = "Bypass Internal IPv6s"
  session_duration = "24h"
  decision         = "bypass"
  include = [
    {
      ip = {
        ip = "2604:2e8b:8077::/56"
      }
  }]
}

resource "cloudflare_zero_trust_access_policy" "external_ips" {
  account_id       = var.cloudflare_account_id
  name             = "Allow External IPs"
  session_duration = "24h"
  decision         = "allow"
  include = [
    {
      login_method = {
        id = cloudflare_zero_trust_access_identity_provider.authentik.id
      }
  }]
  require = [
    {
      oidc = {
        claim_name           = "groups"
        claim_value          = "authentik Admins"
        identity_provider_id = cloudflare_zero_trust_access_identity_provider.authentik.id
      }
  }]
}

resource "cloudflare_zero_trust_access_application" "traefik" {
  allowed_idps = [
    cloudflare_zero_trust_access_identity_provider.authentik.id
  ]
  auto_redirect_to_identity = false
  enable_binding_cookie     = false
  options_preflight_bypass  = false
  domain                    = cloudflare_dns_record.traefik.name
  type                      = "self_hosted"
  account_id                = var.cloudflare_account_id
  session_duration          = "15m"
  name                      = "Traefik"
  policies = [
    {
      id = cloudflare_zero_trust_access_policy.internal_ips.id
    },
    {
      id = cloudflare_zero_trust_access_policy.external_ips.id
    },
    {
      id = cloudflare_zero_trust_access_policy.internal_ips-v6.id
    }
  ]
}

resource "cloudflare_zero_trust_access_application" "pikvm" {
  allowed_idps = [
    cloudflare_zero_trust_access_identity_provider.authentik.id
  ]
  auto_redirect_to_identity = false
  enable_binding_cookie     = false
  options_preflight_bypass  = false
  domain                    = cloudflare_dns_record.pikvm.name
  type                      = "self_hosted"
  account_id                = var.cloudflare_account_id
  session_duration          = "15m"
  name                      = "PiKVM"
  policies = [
    {
      id = cloudflare_zero_trust_access_policy.internal_ips.id
    },
    {
      id = cloudflare_zero_trust_access_policy.external_ips.id
    },
    {
      id = cloudflare_zero_trust_access_policy.internal_ips-v6.id
    }
  ]
}

resource "cloudflare_zero_trust_access_application" "minecraft" {
  allowed_idps = [
    cloudflare_zero_trust_access_identity_provider.authentik.id
  ]
  auto_redirect_to_identity = false
  enable_binding_cookie     = false
  options_preflight_bypass  = false
  domain                    = cloudflare_dns_record.mc.name
  type                      = "self_hosted"
  account_id                = var.cloudflare_account_id
  session_duration          = "15m"
  name                      = "Minecraft"
  policies = [
    {
      id = cloudflare_zero_trust_access_policy.internal_ips.id
    },
    {
      id = cloudflare_zero_trust_access_policy.external_ips.id
    },
    {
      id = cloudflare_zero_trust_access_policy.internal_ips-v6.id
    }
  ]
}

resource "cloudflare_zero_trust_access_application" "pgadmin" {
  allowed_idps = [
    cloudflare_zero_trust_access_identity_provider.authentik.id
  ]
  auto_redirect_to_identity = false
  enable_binding_cookie     = false
  options_preflight_bypass  = false
  domain                    = cloudflare_dns_record.pgadmin.name
  type                      = "self_hosted"
  account_id                = var.cloudflare_account_id
  session_duration          = "15m"
  name                      = "PgAdmin"
  policies = [
    {
      id = cloudflare_zero_trust_access_policy.internal_ips.id
    },
    {
      id = cloudflare_zero_trust_access_policy.external_ips.id
    },
    {
      id = cloudflare_zero_trust_access_policy.internal_ips-v6.id
    }
  ]
}

resource "cloudflare_zero_trust_access_application" "synology" {
  allowed_idps = [
    cloudflare_zero_trust_access_identity_provider.authentik.id
  ]
  auto_redirect_to_identity = false
  enable_binding_cookie     = false
  options_preflight_bypass  = false
  domain                    = cloudflare_dns_record.synology.name
  type                      = "self_hosted"
  account_id                = var.cloudflare_account_id
  session_duration          = "15m"
  name                      = "Synology"
  policies = [
    {
      id = cloudflare_zero_trust_access_policy.internal_ips.id
    },
    {
      id = cloudflare_zero_trust_access_policy.external_ips.id
    },
    {
      id = cloudflare_zero_trust_access_policy.internal_ips-v6.id
    }
  ]
}

resource "cloudflare_zero_trust_access_application" "databasus" {
  allowed_idps = [
    cloudflare_zero_trust_access_identity_provider.authentik.id
  ]
  auto_redirect_to_identity = false
  enable_binding_cookie     = false
  options_preflight_bypass  = false
  domain                    = cloudflare_dns_record.databasus.name
  type                      = "self_hosted"
  account_id                = var.cloudflare_account_id
  session_duration          = "15m"
  name                      = "Databasus"
  policies = [
    {
      id = cloudflare_zero_trust_access_policy.internal_ips.id
    },
    {
      id = cloudflare_zero_trust_access_policy.external_ips.id
    },
    {
      id = cloudflare_zero_trust_access_policy.internal_ips-v6.id
    }
  ]
}

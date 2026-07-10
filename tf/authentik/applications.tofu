output "authentik_cloudflare_client_id" {
  value = authentik_provider_oauth2.cloudflare.client_id
}

output "authentik_cloudflare_client_secret" {
  value     = authentik_provider_oauth2.cloudflare.client_secret
  sensitive = true
}

resource "authentik_provider_oauth2" "cloudflare" {
  access_token_validity = "minutes=5"
  allowed_redirect_uris = [{
    matching_mode     = "strict",
    redirect_uri_type = "authorization",
    url               = "https://jstockley.cloudflareaccess.com/cdn-cgi/access/callback",
  }]
  name = "Cloudflare"
  property_mappings = [
    "4a51d5ca-8d95-4145-8fed-e400b9aac760",
    "14f1df8f-0ab0-4337-ad1d-08f59fa63e95",
    "4fe26886-06bc-4c83-8f21-beb85752491f",
  ]
  client_id          = "Y5eqZC2y7N2XMuoTjBApYtbNnUH2h0xPxPgNfcrJ"
  authorization_flow = "0baa88b2-76ec-49a3-9924-358bb13ba743"
  invalidation_flow  = "46110172-b91f-4d45-acd9-b559ac3994c8"
  signing_key        = "da130ba5-244d-41c9-8982-c37e23beac27"
}

resource "authentik_policy_binding" "cloudflare-access" {
  target = authentik_application.cloudflare.uuid
  group  = authentik_group.cloudflare-access.id
  order  = 0
}

resource "authentik_application" "cloudflare" {
  name              = "Cloudflare"
  slug              = "cloudflare"
  protocol_provider = authentik_provider_oauth2.cloudflare.id
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/cloudflare.svg"
}

resource "authentik_provider_oauth2" "homeassistant" {
  access_token_validity = "minutes=5"
  allowed_redirect_uris = [
    {
      matching_mode     = "strict",
      redirect_uri_type = "authorization",
      url               = "https://${data.terraform_remote_state.cloudflare.outputs.home_dns_record_name}/auth/openid/callback"
    },
    {
      matching_mode     = "strict",
      redirect_uri_type = "authorization",
      url               = "https://home.${data.terraform_remote_state.adguard.outputs.local_wildcard}/auth/openid/callback"

    },
    {
      matching_mode     = "strict",
      redirect_uri_type = "authorization",
      url               = "http://homeassistant.local:8123/auth/openid/callback"

    }
  ]
  authorization_flow = "0baa88b2-76ec-49a3-9924-358bb13ba743"
  client_id          = "L1MWdx5EC0IxFSXU87wBphPsBuMpJp6CUmIe8w5K"
  invalidation_flow  = "46110172-b91f-4d45-acd9-b559ac3994c8"
  name               = "Home Assistant"
  property_mappings = [
    "4a51d5ca-8d95-4145-8fed-e400b9aac760",
    "14f1df8f-0ab0-4337-ad1d-08f59fa63e95",
    "4fe26886-06bc-4c83-8f21-beb85752491f",
  ]
  signing_key = "da130ba5-244d-41c9-8982-c37e23beac27"
}

resource "authentik_application" "homeassistant" {
  name              = "Home Assistant"
  slug              = "home-assistant"
  protocol_provider = authentik_provider_oauth2.homeassistant.id
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/home-assistant.svg"
}

resource "authentik_policy_binding" "homeassistant-access" {
  target = authentik_application.homeassistant.uuid
  group  = authentik_group.home-assistant-access.id
  order  = 0
}

resource "authentik_provider_oauth2" "airflow" {
  access_token_validity = "minutes=5"
  allowed_redirect_uris = [
    {
      matching_mode     = "strict",
      redirect_uri_type = "authorization",
      url               = "https://${data.terraform_remote_state.cloudflare.outputs.airflow_dns_record_name}/auth/oauth-authorized/authentik"
    }
  ]
  authorization_flow = "0baa88b2-76ec-49a3-9924-358bb13ba743"
  client_id          = "XWSMEaXaUZtYUOBmzLTPVWQ5jB7WVmB54GE65IAL"
  invalidation_flow  = "46110172-b91f-4d45-acd9-b559ac3994c8"
  name               = "Airflow"
  property_mappings = [
    "4a51d5ca-8d95-4145-8fed-e400b9aac760",
    "14f1df8f-0ab0-4337-ad1d-08f59fa63e95",
    "4fe26886-06bc-4c83-8f21-beb85752491f",
  ]
  signing_key = "da130ba5-244d-41c9-8982-c37e23beac27"
}

resource "authentik_application" "airflow" {
  name              = "Airflow"
  slug              = "airflow"
  protocol_provider = authentik_provider_oauth2.airflow.id
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/apache-airflow.svg"
}

resource "authentik_policy_binding" "airflow-access" {
  target = authentik_application.airflow.uuid
  group  = authentik_group.airflow-access.id
  order  = 0
}

resource "authentik_provider_oauth2" "airflow-internal" {
  access_token_validity = "minutes=5"
  allowed_redirect_uris = [
    {
      matching_mode     = "strict",
      redirect_uri_type = "authorization",
      url               = "https://airflow.${data.terraform_remote_state.adguard.outputs.local_wildcard}/auth/oauth-authorized/authentik"
    }
  ]
  authorization_flow = "0baa88b2-76ec-49a3-9924-358bb13ba743"
  client_id          = "DrI2FN7eij5c5ui5k8SkgXBRRjYJfbEDKlPZji2w"
  invalidation_flow  = "46110172-b91f-4d45-acd9-b559ac3994c8"
  name               = "Airflow (Internal)"
  property_mappings = [
    "4a51d5ca-8d95-4145-8fed-e400b9aac760",
    "14f1df8f-0ab0-4337-ad1d-08f59fa63e95",
    "4fe26886-06bc-4c83-8f21-beb85752491f",
  ]
  signing_key = "da130ba5-244d-41c9-8982-c37e23beac27"
}

resource "authentik_application" "airflow-internal" {
  name              = "Airflow (Internal)"
  slug              = "airflow-internal"
  protocol_provider = authentik_provider_oauth2.airflow-internal.id
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/apache-airflow.svg"
}

resource "authentik_policy_binding" "airflow-internal-access" {
  target = authentik_application.airflow-internal.uuid
  group  = authentik_group.airflow-access.id
  order  = 0
}

resource "authentik_provider_oauth2" "airflow-dev" {
  access_token_validity = "minutes=5"
  allowed_redirect_uris = [
    {
      matching_mode     = "strict",
      redirect_uri_type = "authorization",
      url               = "http://localhost:8080/auth/oauth-authorized/authentik"
    }
  ]
  authorization_flow = "0baa88b2-76ec-49a3-9924-358bb13ba743"
  client_id          = "1QLST1WJaaNbk7r9xGHv5spelxyIpvB0RArKjxn5"
  invalidation_flow  = "46110172-b91f-4d45-acd9-b559ac3994c8"
  name               = "Airflow (Dev)"
  property_mappings = [
    "4a51d5ca-8d95-4145-8fed-e400b9aac760",
    "14f1df8f-0ab0-4337-ad1d-08f59fa63e95",
    "4fe26886-06bc-4c83-8f21-beb85752491f",
  ]
  signing_key = "da130ba5-244d-41c9-8982-c37e23beac27"
}

resource "authentik_application" "airflow-dev" {
  name              = "Airflow (Dev)"
  slug              = "airflow-dev"
  protocol_provider = authentik_provider_oauth2.airflow-dev.id
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/apache-airflow.svg"
}

resource "authentik_policy_binding" "airflow-dev-access" {
  target = authentik_application.airflow-dev.uuid
  group  = authentik_group.airflow-access.id
  order  = 0
}

resource "authentik_provider_oauth2" "forgejo" {
  access_token_validity = "minutes=5"
  allowed_redirect_uris = [
    {
      matching_mode     = "strict",
      redirect_uri_type = "authorization",
      url               = "https://${data.terraform_remote_state.cloudflare.outputs.forgejo_dns_record_name}/user/oauth2/Authentik/callback"
    }
  ]
  authorization_flow = "0baa88b2-76ec-49a3-9924-358bb13ba743"
  client_id          = "aFPmalIM8sOPGEYZbsaTQ2ZRpqtFEZIuHesZeMhY"
  invalidation_flow  = "46110172-b91f-4d45-acd9-b559ac3994c8"
  name               = "Forgejo"
  property_mappings = [
    "4a51d5ca-8d95-4145-8fed-e400b9aac760",
    "14f1df8f-0ab0-4337-ad1d-08f59fa63e95",
    "4fe26886-06bc-4c83-8f21-beb85752491f",
  ]
  signing_key = "da130ba5-244d-41c9-8982-c37e23beac27"
}

resource "authentik_application" "forgejo" {
  name              = "Forgejo"
  slug              = "forgejo"
  protocol_provider = authentik_provider_oauth2.forgejo.id
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/forgejo.svg"
}

resource "authentik_policy_binding" "forgejo" {
  target = authentik_application.forgejo.uuid
  group  = authentik_group.forgejo-access.id
  order  = 0
}

resource "authentik_provider_oauth2" "nextcloud" {
  access_token_validity = "minutes=5"
  allowed_redirect_uris = [
    {
      matching_mode     = "strict",
      redirect_uri_type = "authorization",
      url               = "https://${data.terraform_remote_state.cloudflare.outputs.nextcloud_dns_record_name}/apps/user_oidc/code"
    }
  ]
  authorization_flow = "0baa88b2-76ec-49a3-9924-358bb13ba743"
  client_id          = "MFheXhPNBKB4tQEvY4xhszAZ6VxlhK9PjKMYR7xX"
  invalidation_flow  = "46110172-b91f-4d45-acd9-b559ac3994c8"
  name               = "Nextcloud"
  property_mappings = [
    "4a51d5ca-8d95-4145-8fed-e400b9aac760",
    "14f1df8f-0ab0-4337-ad1d-08f59fa63e95",
    "4fe26886-06bc-4c83-8f21-beb85752491f",
  ]
  signing_key = "da130ba5-244d-41c9-8982-c37e23beac27"
}

resource "authentik_application" "nextcloud" {
  name              = "Nextcloud"
  slug              = "nextcloud"
  protocol_provider = authentik_provider_oauth2.nextcloud.id
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/nextcloud.svg"
}

resource "authentik_policy_binding" "nextcloud" {
  target = authentik_application.nextcloud.uuid
  group  = authentik_group.nextcloud-access.id
  order  = 0
}

resource "authentik_provider_oauth2" "paperless" {
  access_token_validity = "minutes=5"
  allowed_redirect_uris = [
    {
      matching_mode     = "strict",
      redirect_uri_type = "authorization",
      url               = "https://paperless.${data.terraform_remote_state.adguard.outputs.local_wildcard}/accounts/oidc/authentik/login/callback/"
    }
  ]
  authorization_flow = "0baa88b2-76ec-49a3-9924-358bb13ba743"
  client_id          = "CWSg33B30WeVvV9UuXIJpuC2QcDKQeUOPQVgNZfo"
  invalidation_flow  = "46110172-b91f-4d45-acd9-b559ac3994c8"
  name               = "Paperless"
  property_mappings = [
    "4a51d5ca-8d95-4145-8fed-e400b9aac760",
    "14f1df8f-0ab0-4337-ad1d-08f59fa63e95",
    "4fe26886-06bc-4c83-8f21-beb85752491f",
  ]
  signing_key = "da130ba5-244d-41c9-8982-c37e23beac27"
}

resource "authentik_application" "paperless" {
  name              = "Paperless"
  slug              = "paperless"
  protocol_provider = authentik_provider_oauth2.paperless.id
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/paperless-ngx.svg"
}

resource "authentik_policy_binding" "paperless" {
  target = authentik_application.paperless.uuid
  group  = authentik_group.paperless-access.id
  order  = 0
}

resource "authentik_provider_oauth2" "synology" {
  access_token_validity = "minutes=5"
  allowed_redirect_uris = [
    {
      matching_mode     = "strict",
      redirect_uri_type = "authorization",
      url               = "https://nas.${data.terraform_remote_state.adguard.outputs.local_wildcard}"
    },
    {
      matching_mode     = "strict",
      redirect_uri_type = "authorization",
      url               = "https://${data.terraform_remote_state.cloudflare.outputs.synology_dns_record_name}"
    }
  ]
  authorization_flow = "0baa88b2-76ec-49a3-9924-358bb13ba743"
  client_id          = "OnKBwOvBqFGRr0HkFbHk01aA7pq98RuQ8Ypu7HG2"
  invalidation_flow  = "46110172-b91f-4d45-acd9-b559ac3994c8"
  name               = "Synology"
  property_mappings = [
    "4a51d5ca-8d95-4145-8fed-e400b9aac760",
    "14f1df8f-0ab0-4337-ad1d-08f59fa63e95",
    "4fe26886-06bc-4c83-8f21-beb85752491f",
  ]
  signing_key = "da130ba5-244d-41c9-8982-c37e23beac27"
}

resource "authentik_application" "synology" {
  name              = "Synology"
  slug              = "synology"
  protocol_provider = authentik_provider_oauth2.synology.id
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/synology-dsm.svg"
}

resource "authentik_policy_binding" "synology" {
  target = authentik_application.synology.uuid
  group  = authentik_group.synology-access.id
  order  = 0
}

resource "authentik_provider_oauth2" "tailscale" {
  access_token_validity = "minutes=5"
  allowed_redirect_uris = [
    {
      matching_mode     = "strict",
      redirect_uri_type = "authorization",
      url               = "https://login.tailscale.com/a/oauth_response"
    }
  ]
  authorization_flow = "0baa88b2-76ec-49a3-9924-358bb13ba743"
  client_id          = "LJIUFWKbWnvZ33AMkMoYcAHYJ7tfy2NM9ojLSwxR"
  invalidation_flow  = "46110172-b91f-4d45-acd9-b559ac3994c8"
  name               = "Tasilcale"
  property_mappings = [
    "4a51d5ca-8d95-4145-8fed-e400b9aac760",
    "14f1df8f-0ab0-4337-ad1d-08f59fa63e95",
    "4fe26886-06bc-4c83-8f21-beb85752491f",
  ]
  signing_key = "da130ba5-244d-41c9-8982-c37e23beac27"
}

resource "authentik_application" "tailscale" {
  name              = "Tailscale"
  slug              = "tailscale"
  protocol_provider = authentik_provider_oauth2.tailscale.id
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/tailscale-light.svg"
}

resource "authentik_policy_binding" "tailscale" {
  target = authentik_application.tailscale.uuid
  group  = authentik_group.tailscale-access.id
  order  = 0
}

resource "authentik_provider_oauth2" "proxmox" {
  access_token_validity = "minutes=5"
  allowed_redirect_uris = [
    {
      matching_mode     = "strict",
      redirect_uri_type = "authorization",
      url               = "https://proxmox.${data.terraform_remote_state.adguard.outputs.local_wildcard}"
    }
  ]
  authorization_flow = "0baa88b2-76ec-49a3-9924-358bb13ba743"
  client_id          = "NveGGE53TORdj3GMiIWfCEL01MFeR4sCPDWFwwiU"
  invalidation_flow  = "46110172-b91f-4d45-acd9-b559ac3994c8"
  name               = "Proxmox"
  property_mappings = [
    "4a51d5ca-8d95-4145-8fed-e400b9aac760",
    "14f1df8f-0ab0-4337-ad1d-08f59fa63e95",
    "4fe26886-06bc-4c83-8f21-beb85752491f",
  ]
  signing_key = "da130ba5-244d-41c9-8982-c37e23beac27"
  sub_mode    = "user_email"
}

resource "authentik_application" "proxmox" {
  name              = "Proxmox"
  slug              = "proxmox"
  protocol_provider = authentik_provider_oauth2.proxmox.id
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/proxmox-light.svg"
}

resource "authentik_policy_binding" "proxmox" {
  target = authentik_application.proxmox.uuid
  group  = authentik_group.proxmox-access.id
  order  = 0
}

resource "authentik_provider_oauth2" "pg-admin-local" {
  access_token_validity = "minutes=5"
  allowed_redirect_uris = [
    {
      matching_mode     = "strict",
      redirect_uri_type = "authorization",
      url               = "https://pgadmin.${data.terraform_remote_state.adguard.outputs.local_wildcard}/oauth2/authorize"
    }
  ]
  authorization_flow = "0baa88b2-76ec-49a3-9924-358bb13ba743"
  client_id          = "akBCvqkKPR9qkvj7thfk9Y8fVorDzId3dl0gqb8J"
  invalidation_flow  = "46110172-b91f-4d45-acd9-b559ac3994c8"
  name               = "PgAdmin (Local)"
  property_mappings = [
    "4a51d5ca-8d95-4145-8fed-e400b9aac760",
    "14f1df8f-0ab0-4337-ad1d-08f59fa63e95",
    "4fe26886-06bc-4c83-8f21-beb85752491f",
  ]
  signing_key = "da130ba5-244d-41c9-8982-c37e23beac27"
}

resource "authentik_application" "pg-admin-local" {
  name              = "PgAdmin (Local)"
  slug              = "pg-admin-local"
  protocol_provider = authentik_provider_oauth2.pg-admin-local.id
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/pgadmin.svg"
}

resource "authentik_policy_binding" "pg-admin-local" {
  target = authentik_application.pg-admin-local.uuid
  group  = authentik_group.pg-admin-access.id
  order  = 0
}

resource "authentik_provider_oauth2" "pg-admin-external" {
  access_token_validity = "minutes=5"
  allowed_redirect_uris = [
    {
      matching_mode     = "strict",
      redirect_uri_type = "authorization",
      url               = "https://${data.terraform_remote_state.cloudflare.outputs.pgadmin_dns_record_name}/oauth2/authorize"
    }
  ]
  authorization_flow = "0baa88b2-76ec-49a3-9924-358bb13ba743"
  client_id          = "PwmmIHTfK6C7ihje2o7PqM6aFEgbe5QL9N82coCa"
  invalidation_flow  = "46110172-b91f-4d45-acd9-b559ac3994c8"
  name               = "PgAdmin (External)"
  property_mappings = [
    "4a51d5ca-8d95-4145-8fed-e400b9aac760",
    "14f1df8f-0ab0-4337-ad1d-08f59fa63e95",
    "4fe26886-06bc-4c83-8f21-beb85752491f",
  ]
  signing_key = "da130ba5-244d-41c9-8982-c37e23beac27"
}

resource "authentik_application" "pg-admin-external" {
  name              = "PgAdmin (External)"
  slug              = "pg-admin-external"
  protocol_provider = authentik_provider_oauth2.pg-admin-external.id
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/pgadmin.svg"
}

resource "authentik_policy_binding" "pg-admin-external" {
  target = authentik_application.pg-admin-external.uuid
  group  = authentik_group.pg-admin-access.id
  order  = 0
}

resource "authentik_provider_oauth2" "beszel" {
  access_token_validity = "minutes=5"
  allowed_redirect_uris = [
    {
      matching_mode     = "strict",
      redirect_uri_type = "authorization",
      url               = "https://stats.${data.terraform_remote_state.adguard.outputs.local_wildcard}/api/oauth2-redirect"
    }
  ]
  authorization_flow = "0baa88b2-76ec-49a3-9924-358bb13ba743"
  client_id          = "AFIHnE8JkYQUVFrYep8aIoCMgbFA4qqgtGeKddw6"
  invalidation_flow  = "46110172-b91f-4d45-acd9-b559ac3994c8"
  name               = "Beszel"
  property_mappings = [
    "4a51d5ca-8d95-4145-8fed-e400b9aac760",
    "14f1df8f-0ab0-4337-ad1d-08f59fa63e95",
    "4fe26886-06bc-4c83-8f21-beb85752491f",
  ]
  signing_key = "da130ba5-244d-41c9-8982-c37e23beac27"
}

resource "authentik_application" "beszel" {
  name              = "Beszel"
  slug              = "beszel"
  protocol_provider = authentik_provider_oauth2.beszel.id
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/beszel-light.svg"
}

resource "authentik_policy_binding" "beszel" {
  target = authentik_application.beszel.uuid
  group  = authentik_group.beszel-access.id
  order  = 0
}

resource "authentik_provider_proxy" "open-speed-test-local" {
  access_token_validity        = "minutes=5"
  authorization_flow           = "0baa88b2-76ec-49a3-9924-358bb13ba743"
  invalidation_flow            = "46110172-b91f-4d45-acd9-b559ac3994c8"
  name                         = "OpenSpeed Test (Local)"
  external_host                = "https://speed.${data.terraform_remote_state.adguard.outputs.local_wildcard}"
  internal_host                = "http://openspeedtest:3000"
  mode                         = "proxy"
  internal_host_ssl_validation = false
}

resource "authentik_application" "open-speed-test-local" {
  name              = "OpenSpeed Test (Local)"
  slug              = "open-speed-test-local"
  protocol_provider = authentik_provider_proxy.open-speed-test-local.id
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/openspeedtest.svg"
  meta_launch_url   = "https://speed.${data.terraform_remote_state.adguard.outputs.local_wildcard}"
}

resource "authentik_provider_proxy" "open-speed-test" {
  access_token_validity        = "minutes=5"
  authorization_flow           = "0baa88b2-76ec-49a3-9924-358bb13ba743"
  invalidation_flow            = "46110172-b91f-4d45-acd9-b559ac3994c8"
  name                         = "OpenSpeed Test"
  external_host                = "https://${data.terraform_remote_state.cloudflare.outputs.open_speedtest_dns_record_name}"
  internal_host                = "http://openspeedtest:3000"
  mode                         = "proxy"
  internal_host_ssl_validation = false
}

resource "authentik_application" "open-speed-test" {
  name              = "OpenSpeed Test"
  slug              = "open-speed-test"
  protocol_provider = authentik_provider_proxy.open-speed-test.id
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/openspeedtest.svg"
  meta_launch_url   = "https://${data.terraform_remote_state.cloudflare.outputs.open_speedtest_dns_record_name}"
}

resource "authentik_policy_binding" "open-speed-test-local" {
  target = authentik_application.open-speed-test-local.uuid
  group  = authentik_group.open-speedtest-access.id
  order  = 0
}

resource "authentik_policy_binding" "open-speed-test" {
  target = authentik_application.open-speed-test.uuid
  group  = authentik_group.open-speedtest-access.id
  order  = 0
}

resource "authentik_provider_proxy" "traefik-local" {
  access_token_validity        = "minutes=5"
  authorization_flow           = "0baa88b2-76ec-49a3-9924-358bb13ba743"
  invalidation_flow            = "46110172-b91f-4d45-acd9-b559ac3994c8"
  name                         = "Traefik (Local)"
  external_host                = "https://traefik.${data.terraform_remote_state.adguard.outputs.local_wildcard}"
  internal_host                = "http://traefik:8080"
  mode                         = "proxy"
  internal_host_ssl_validation = false
}

resource "authentik_application" "traefik-local" {
  name              = "Traefik (Local)"
  slug              = "traefik-local"
  protocol_provider = authentik_provider_proxy.traefik-local.id
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/traefik-proxy.svg"
  meta_launch_url   = "https://traefik.${data.terraform_remote_state.adguard.outputs.local_wildcard}"
}

resource "authentik_policy_binding" "traefik-local" {
  target = authentik_application.traefik-local.uuid
  group  = authentik_group.traefik-local-access.id
  order  = 0
}

resource "authentik_provider_oauth2" "immich" {
  access_token_validity = "minutes=5"
  allowed_redirect_uris = [
    {
      matching_mode     = "strict",
      redirect_uri_type = "authorization",
      url               = "https://${data.terraform_remote_state.cloudflare.outputs.photos_dns_record_name}/auth/login"
    },
    {
      matching_mode     = "strict",
      redirect_uri_type = "authorization",
      url               = "https://photos.${data.terraform_remote_state.adguard.outputs.local_wildcard}/auth/login"
    },
    {
      matching_mode     = "regex",
      redirect_uri_type = "authorization",
      url               = "app.immich:///oauth-callback*"
    }
  ]
  authorization_flow = "0baa88b2-76ec-49a3-9924-358bb13ba743"
  client_id          = "AXFoL1rXApIZN9tYX84QtMiAREYfASTvPIyJqgYB"
  invalidation_flow  = "46110172-b91f-4d45-acd9-b559ac3994c8"
  name               = "Immich"
  property_mappings = [
    "4a51d5ca-8d95-4145-8fed-e400b9aac760",
    "14f1df8f-0ab0-4337-ad1d-08f59fa63e95",
    "4fe26886-06bc-4c83-8f21-beb85752491f",
  ]
  signing_key = "da130ba5-244d-41c9-8982-c37e23beac27"
}

resource "authentik_application" "immich" {
  name              = "Immich"
  slug              = "immich"
  protocol_provider = authentik_provider_oauth2.immich.id
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/immich.svg"
}

resource "authentik_policy_binding" "immich" {
  target = authentik_application.immich.uuid
  group  = authentik_group.immich-access.id
  order  = 0
}

resource "authentik_provider_proxy" "unifi-toolkit" {
  access_token_validity        = "minutes=5"
  authorization_flow           = "0baa88b2-76ec-49a3-9924-358bb13ba743"
  invalidation_flow            = "46110172-b91f-4d45-acd9-b559ac3994c8"
  name                         = "UniFi Toolkit"
  external_host                = "https://unifi-toolkit.${data.terraform_remote_state.adguard.outputs.local_wildcard}"
  internal_host                = "http://unifi-toolkit:8000"
  mode                         = "proxy"
  internal_host_ssl_validation = false
}

resource "authentik_application" "unifi-toolkit" {
  name              = "UniFi Toolkit"
  slug              = "unifi-toolkit"
  protocol_provider = authentik_provider_proxy.unifi-toolkit.id
  meta_icon         = "https://raw.githubusercontent.com/Crosstalk-Solutions/unifi-toolkit/refs/heads/main/logo/2022-Crosstalk-Solutions-Icon.png"
  meta_launch_url   = "https://unifi-toolkit.${data.terraform_remote_state.adguard.outputs.local_wildcard}"
}

resource "authentik_policy_binding" "unifi-toolkit" {
  target = authentik_application.unifi-toolkit.uuid
  group  = authentik_group.unifi-access.id
  order  = 0
}

resource "authentik_provider_oauth2" "arcane" {
  access_token_validity = "minutes=5"
  allowed_redirect_uris = [
    {
      matching_mode     = "strict",
      redirect_uri_type = "authorization",
      url               = "https://arcane.${data.terraform_remote_state.adguard.outputs.local_wildcard}/auth/oidc/callback"
    }
  ]
  authorization_flow = "0baa88b2-76ec-49a3-9924-358bb13ba743"
  client_id          = "vYQq0ffAnfGnkuZidCfj3HpJrmU0f1AQmMC1rkO0"
  grant_types = [
    "authorization_code",
    "hybrid",
    "implicit",
    "client_credentials",
    "password",
    "urn:ietf:params:oauth:grant-type:device_code",
    "refresh_token",
  ]
  invalidation_flow = "46110172-b91f-4d45-acd9-b559ac3994c8"
  name              = "Arcane"
  property_mappings = [
    "4a51d5ca-8d95-4145-8fed-e400b9aac760",
    "14f1df8f-0ab0-4337-ad1d-08f59fa63e95",
    "4fe26886-06bc-4c83-8f21-beb85752491f",
  ]
  signing_key = "da130ba5-244d-41c9-8982-c37e23beac27"
}

resource "authentik_application" "arcane" {
  name              = "Arcane"
  slug              = "arcane"
  protocol_provider = authentik_provider_oauth2.arcane.id
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/arcane.svg"
}

resource "authentik_policy_binding" "arcane" {
  target = authentik_application.arcane.uuid
  group  = authentik_group.arcane-access.id
  order  = 0
}

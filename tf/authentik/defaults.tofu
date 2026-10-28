# Authentik owns these defaults; look them up rather than adopting them.
data "authentik_flow" "provider_authorization" {
  slug = "default-provider-authorization-implicit-consent"
}

data "authentik_flow" "provider_invalidation" {
  slug = "default-provider-invalidation-flow"
}

data "authentik_property_mapping_provider_scope" "openid" {
  managed = "goauthentik.io/providers/oauth2/scope-openid"
}

data "authentik_property_mapping_provider_scope" "email" {
  managed = "goauthentik.io/providers/oauth2/scope-email"
}

data "authentik_property_mapping_provider_scope" "profile" {
  managed = "goauthentik.io/providers/oauth2/scope-profile"
}

data "authentik_certificate_key_pair" "signing" {
  name              = "authentik Self-signed Certificate"
  fetch_certificate = false
  fetch_key         = false
}

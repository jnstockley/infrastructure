resource "authentik_outpost" "proxy" {
  name = "authentik Embedded Outpost"
  protocol_providers = [
    authentik_provider_proxy.open-speed-test.id,
    authentik_provider_proxy.open-speed-test-local.id,
    authentik_provider_proxy.traefik-local.id,
    authentik_provider_proxy.unifi-toolkit.id,
  ]
}

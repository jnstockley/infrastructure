resource "authentik_user" "jackstockley" {
  username = "jackstockley"
  name     = "Jack Stockley"
  email    = "jack@jstockley.com"
  groups = [
    authentik_group.authentik_admins.id,
    authentik_group.airflow-access.id,
    authentik_group.cloudflare-access.id,
    authentik_group.forgejo-access.id,
    authentik_group.home-assistant-access.id,
    authentik_group.immich-access.id,
    authentik_group.nextcloud-access.id,
    authentik_group.paperless-access.id,
    authentik_group.synology-access.id,
    authentik_group.tailscale-access.id,
    authentik_group.proxmox-access.id,
    authentik_group.pg-admin-access.id,
    authentik_group.beszel-access.id,
    authentik_group.open-speedtest-access.id,
    authentik_group.traefik-local-access.id,
    authentik_group.unifi-access.id,
  ]
}

resource "authentik_user" "claylarson" {
  username = "claylarson"
  name     = "Clay Larson"
  email    = "claylarson3@icloud.com"
  groups = [
    authentik_group.home-assistant-access.id,
    authentik_group.immich-access.id,
    authentik_group.nextcloud-access.id,
    authentik_group.open-speedtest-access.id
  ]
}

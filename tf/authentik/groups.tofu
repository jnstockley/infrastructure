resource "authentik_group" "authentik_admins" {
  name         = "authentik Admins"
  is_superuser = true
}

resource "authentik_group" "airflow-access" {
  name         = "Airflow Access"
  is_superuser = false
}

resource "authentik_group" "cloudflare-access" {
  name         = "Cloudflare Access"
  is_superuser = false
}

resource "authentik_group" "gitea-access" {
  name         = "Gitea Access"
  is_superuser = false
}

resource "authentik_group" "home-assistant-access" {
  name         = "Home Assistant Access"
  is_superuser = false
}

resource "authentik_group" "immich-access" {
  name         = "Immich Access"
  is_superuser = false
}

resource "authentik_group" "nextcloud-access" {
  name         = "Nextcloud Access"
  is_superuser = false
}

resource "authentik_group" "paperless-access" {
  name         = "Paperless Access"
  is_superuser = false
}

resource "authentik_group" "synology-access" {
  name         = "Synology Access"
  is_superuser = false
}

resource "authentik_group" "tailscale-access" {
  name         = "Tasilscale Access"
  is_superuser = false
}

resource "authentik_group" "proxmox-access" {
  name         = "Proxmox Access"
  is_superuser = false
}

resource "authentik_group" "pg-admin-access" {
  name         = "PgAdmin Access"
  is_superuser = false
}

resource "authentik_group" "beszel-access" {
  name         = "Beszel Access"
  is_superuser = false
}

resource "authentik_group" "open-speedtest-access" {
  name         = "OpenSpeed Test Access"
  is_superuser = false
}

resource "authentik_group" "traefik-local-access" {
  name         = "Traefik Access"
  is_superuser = false
}
resource "authentik_group" "unifi-access" {
  name         = "UniFi Access"
  is_superuser = false
}

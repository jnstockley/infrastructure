resource "uptimekuma_monitor_group" "adguard-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "AdGuard Home"
}

resource "uptimekuma_monitor_group" "airflow-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "Airflow"
}

resource "uptimekuma_monitor_group" "authentik-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "Authentik"
}

resource "uptimekuma_monitor_group" "beszel-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "Beszel"
}

resource "uptimekuma_monitor_group" "bitwarden-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "Bitwarden"
}

resource "uptimekuma_monitor_group" "bsn-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "BSN"
}

resource "uptimekuma_monitor_group" "databasus-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "Databasus"
}

resource "uptimekuma_monitor_group" "forgejo-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "Forgejo"
}

resource "uptimekuma_monitor_group" "immich-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "Immich"
}

resource "uptimekuma_monitor_group" "infiscal-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "Infiscal"
}

resource "uptimekuma_monitor_group" "mariadb-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "MariaDB"
}

resource "uptimekuma_monitor_group" "mend-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "Mend"
}

resource "uptimekuma_monitor_group" "minecraft-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "Minecraft"
}

resource "uptimekuma_monitor_group" "n8n-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "n8n"
}

resource "uptimekuma_monitor_group" "nextcloud-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_smtp.smtp-failover.id
  ]
  name = "Nextcloud"
}

resource "uptimekuma_monitor_group" "openspeedtest-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "OpenSpeedTest"
}

resource "uptimekuma_monitor_group" "paperless-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "Paperless"
}

resource "uptimekuma_monitor_group" "postgres-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "PostgreSQL"
}

resource "uptimekuma_monitor_group" "redis-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "Redis"
}

resource "uptimekuma_monitor_group" "syncthing-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "Synchting"
}

resource "uptimekuma_monitor_group" "traefik-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "Traefik"
}

resource "uptimekuma_monitor_group" "unifi-toolkit-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "Unifi Toolkit"
}

resource "uptimekuma_monitor_group" "wireguard-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "WireGuard"
}
resource "uptimekuma_notification_nextcloudtalk" "nextcloud-talk" {
  provider           = uptimekuma.local
  name               = "Nextcloud Talk Notifications"
  host               = "https://nextcloud.jstockley.com"
  conversation_token = var.nextcloud_talk_local_conversation_token
  bot_secret         = var.nextcloud_talk_local_secret
  is_active          = true
  is_default         = false
}

resource "uptimekuma_notification_smtp" "smtp-failover" {
  provider = uptimekuma.local
  name     = "SMTP Notifications"

  # Required fields
  host = "smtp.mail.me.com"
  from = "\"Uptime Kuma Photo Server\" <no-reply@jstockley.com>"
  to   = "jack@jstockley.com"

  # Optional: SMTP server configuration
  port             = 587
  secure           = false
  ignore_tls_error = false

  # Optional: SMTP authentication
  username = "jack.stockley@icloud.com"
  password = var.smtp_password

  # Optional: Email customization
  html_body      = true

  is_active  = true
  is_default = false
}


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

resource "uptimekuma_monitor_group" "gitea-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "Gitea"
}

resource "uptimekuma_monitor_group" "gitlab-runner-group" {
  provider    = uptimekuma.local
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.nextcloud-talk.id
  ]
  name = "GitLab Runner"
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
  name = "openspeedtest"
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
  name = "redis"
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
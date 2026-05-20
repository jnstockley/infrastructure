resource "uptimekuma_monitor_group" "public-airflow-group" {
  provider    = uptimekuma.public
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.public-nextcloud-talk.id
  ]
  name = "Airflow"
}

resource "uptimekuma_monitor_group" "api-group" {
  provider    = uptimekuma.public
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.public-nextcloud-talk.id
  ]
  name = "API"
}

resource "uptimekuma_monitor_group" "public-beszel-group" {
  provider    = uptimekuma.public
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.public-nextcloud-talk.id
  ]
  name = "Beszel"
}

resource "uptimekuma_monitor_group" "cloudflared-group" {
  provider    = uptimekuma.public
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.public-nextcloud-talk.id
  ]
  name = "Cloudflared"
}

resource "uptimekuma_monitor_group" "public-databasus-group" {
  provider    = uptimekuma.public
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.public-nextcloud-talk.id
  ]
  name = "Databasus"
}

resource "uptimekuma_monitor_group" "public-mariadb-group" {
  provider    = uptimekuma.public
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.public-nextcloud-talk.id
  ]
  name = "Mariadb"
}

resource "uptimekuma_monitor_group" "public-postgres-group" {
  provider    = uptimekuma.public
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.public-nextcloud-talk.id
  ]
  name = "Postgres"
}

resource "uptimekuma_monitor_group" "public-redis-group" {
  provider    = uptimekuma.public
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.public-nextcloud-talk.id
  ]
  name = "Redis"
}

resource "uptimekuma_monitor_group" "public-syncthing-group" {
  provider    = uptimekuma.public
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.public-nextcloud-talk.id
  ]
  name = "Syncthing"
}

resource "uptimekuma_monitor_group" "public-traefik-group" {
  provider    = uptimekuma.public
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.public-nextcloud-talk.id
  ]
  name = "Traefik"
}

resource "uptimekuma_monitor_group" "public-wireguard-group" {
  provider    = uptimekuma.public
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_nextcloudtalk.public-nextcloud-talk.id
  ]
  name = "Wireguard"
}

resource "uptimekuma_monitor_group" "iowa-group" {
  provider    = uptimekuma.public
  interval    = 60
  max_retries = 3
  notification_ids = [
    uptimekuma_notification_smtp.public-smtp-failover.id
  ]
  name = "Iowa"
}

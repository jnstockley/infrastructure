resource "uptimekuma_maintenance" "nextcloud-daily-maintenance" {
  provider = uptimekuma.local
  title    = "Nextcloud Daily Update & Backup"
  strategy = "recurring-weekday"
  active   = true

  weekdays = [0, 1, 2, 3, 4, 5, 6, 7]

  start_time = {
    hours   = 1
    minutes = 0
    seconds = 0
  }

  end_time = {
    hours   = 1
    minutes = 10
    seconds = 0
  }
  end_date = null

  timezone = "America/Chicago"
}

resource "uptimekuma_maintenance" "router-reboot-maintenance" {
  provider = uptimekuma.local
  title    = "Router Reboot"
  strategy = "recurring-weekday"
  active   = true

  weekdays = [0, 1, 2, 3, 4, 5, 6, 7]

  start_time = {
    hours   = 3
    minutes = 0
    seconds = 0
  }

  end_time = {
    hours   = 3
    minutes = 10
    seconds = 0
  }
  end_date = null

  timezone = "America/Chicago"
}

resource "uptimekuma_maintenance_monitors" "nextcloud-daily-maintenance-monitors" {
  provider       = uptimekuma.local
  maintenance_id = uptimekuma_maintenance.nextcloud-daily-maintenance.id
  monitor_ids    = [uptimekuma_monitor_group.nextcloud-group.id]
}

resource "uptimekuma_maintenance_monitors" "router-reboot-maintenance-monitors" {
  provider       = uptimekuma.local
  maintenance_id = uptimekuma_maintenance.router-reboot-maintenance.id
  monitor_ids = [
    uptimekuma_monitor_group.forgejo-group.id,
    uptimekuma_monitor_group.infisical-group.id,
    uptimekuma_monitor_group.racknerd-group.id,
    uptimekuma_monitor_group.bitwarden-group.id,
    uptimekuma_monitor_group.home-assistant-group.id,
    uptimekuma_monitor_group.minecraft-group.id,
    uptimekuma_monitor_group.pikvm-group.id,
    uptimekuma_monitor_group.immich-group.id,
    uptimekuma_monitor_group.unifi-group.id,
    uptimekuma_monitor_group.traefik-group.id,
    uptimekuma_monitor_group.mariadb-group.id,
    uptimekuma_monitor_group.postgres-group.id,
    uptimekuma_monitor_group.databasus-group.id,
    uptimekuma_monitor_group.n8n-group.id,
    uptimekuma_monitor_group.paperless-group.id,
    uptimekuma_monitor_group.airflow-group.id,
    uptimekuma_monitor_group.beszel-group.id,
    uptimekuma_monitor_group.nextcloud-group.id,
    uptimekuma_monitor_group.proxmox-group.id,
  ]
}

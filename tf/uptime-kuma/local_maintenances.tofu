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

resource "uptimekuma_maintenance_monitors" "nextcloud-daily-maintenance-monitors" {
  provider       = uptimekuma.local
  maintenance_id = uptimekuma_maintenance.nextcloud-daily-maintenance.id
  monitor_ids    = [uptimekuma_monitor_group.nextcloud-group.id]
}

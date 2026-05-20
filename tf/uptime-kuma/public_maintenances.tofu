resource "uptimekuma_maintenance" "public-router-reboot-maintenance" {
  provider = uptimekuma.public
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

resource "uptimekuma_maintenance_monitors" "public-router-reboot-maintenance-monitors" {
  provider       = uptimekuma.public
  maintenance_id = uptimekuma_maintenance.public-router-reboot-maintenance.id
  monitor_ids    = [uptimekuma_monitor_group.iowa-group.id]
}

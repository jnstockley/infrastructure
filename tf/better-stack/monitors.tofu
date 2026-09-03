resource "betteruptime_heartbeat" "uptime-kuma-local-monitor" {
  name   = "Uptime Kuma Local Monitor"
  period = 300
  grace  = 60
  email  = true
}

# Monitor that passes only when the endpoint returns a specific set of status codes
resource "betteruptime_monitor" "uptime-kuma-public-monitor" {

  url                   = "https://${data.terraform_remote_state.cloudflare.outputs.status_dns_record_name}/status.php"
  monitor_type          = "expected_status_code"
  expected_status_codes = [200, 201, 204]
  email                 = true
}


# Monitor that passes only when the endpoint returns a specific set of status codes
resource "betteruptime_monitor" "adguard-monitor" {
  url                   = "https://${data.terraform_remote_state.cloudflare.outputs.adguard_dns_record_name}"
  monitor_type          = "expected_status_code"
  expected_status_codes = [200, 201, 204]
  email                 = true
}

output "uptime-kuma-local-monitor-heartbeat-url" {
  value = betteruptime_heartbeat.uptime-kuma-local-monitor.url
}

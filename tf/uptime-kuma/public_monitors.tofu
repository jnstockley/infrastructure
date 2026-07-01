resource "uptimekuma_monitor_docker" "public-airflow-triggerer-docker" {
  provider         = uptimekuma.public
  name             = "Triggerer Container"
  docker_host_id   = uptimekuma_docker_host.public_socket.id
  docker_container = "airflow-triggerer"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.public-airflow-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "public-airflow-api-server-docker" {
  provider         = uptimekuma.public
  name             = "API Server Container"
  docker_host_id   = uptimekuma_docker_host.public_socket.id
  docker_container = "airflow-api-server"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.public-airflow-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "public-airflow-dag-processor-docker" {
  provider         = uptimekuma.public
  name             = "DAG Processor Container"
  docker_host_id   = uptimekuma_docker_host.public_socket.id
  docker_container = "airflow-dag-processor"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.public-airflow-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "public-airflow-scheduler-docker" {
  provider         = uptimekuma.public
  name             = "Scheduler Container"
  docker_host_id   = uptimekuma_docker_host.public_socket.id
  docker_container = "airflow-scheduler"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.public-airflow-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "api-docker" {
  provider         = uptimekuma.public
  name             = "Container"
  docker_host_id   = uptimekuma_docker_host.public_socket.id
  docker_container = "api"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.api-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "public-beszel-agent-docker" {
  provider         = uptimekuma.public
  name             = "Agent Container"
  docker_host_id   = uptimekuma_docker_host.public_socket.id
  docker_container = "beszel-agent-racknerd"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.public-beszel-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "cloudflared-docker" {
  provider         = uptimekuma.public
  name             = "Container"
  docker_host_id   = uptimekuma_docker_host.public_socket.id
  docker_container = "cloudflared"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.cloudflared-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "public-databasus-docker" {
  provider         = uptimekuma.public
  name             = "Container"
  docker_host_id   = uptimekuma_docker_host.public_socket.id
  docker_container = "databasus"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.public-databasus-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "public-mariadb-docker" {
  provider         = uptimekuma.public
  name             = "DB Container"
  docker_host_id   = uptimekuma_docker_host.public_socket.id
  docker_container = "mariadb"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.public-mariadb-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "public-phpmyadmin-docker" {
  provider         = uptimekuma.public
  name             = "PHP My Admin Container"
  docker_host_id   = uptimekuma_docker_host.public_socket.id
  docker_container = "phpmyadmin"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.public-mariadb-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "public-postgres-docker" {
  provider         = uptimekuma.public
  name             = "DB Container"
  docker_host_id   = uptimekuma_docker_host.public_socket.id
  docker_container = "postgres"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.public-postgres-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "public-pgadmin-docker" {
  provider         = uptimekuma.public
  name             = "PgAdmin Container"
  docker_host_id   = uptimekuma_docker_host.public_socket.id
  docker_container = "pgadmin"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.public-postgres-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "public-redis-docker" {
  provider         = uptimekuma.public
  name             = "Container"
  docker_host_id   = uptimekuma_docker_host.public_socket.id
  docker_container = "redis"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.public-redis-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "public-syncthing-docker" {
  provider         = uptimekuma.public
  name             = "Container"
  docker_host_id   = uptimekuma_docker_host.public_socket.id
  docker_container = "syncthing"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.public-syncthing-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "public-traefik-docker" {
  provider         = uptimekuma.public
  name             = "Container"
  docker_host_id   = uptimekuma_docker_host.public_socket.id
  docker_container = "traefik"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.public-traefik-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "public-wireguard-docker" {
  provider         = uptimekuma.public
  name             = "Container"
  docker_host_id   = uptimekuma_docker_host.public_socket.id
  docker_container = "wireguard"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.public-wireguard-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_http_keyword" "public-airflow-http" {
  provider            = uptimekuma.public
  name                = "WebPage"
  url                 = "https://${data.terraform_remote_state.cloudflare.outputs.airflow_dns_record_name}/api/v2/monitor/health"
  keyword             = "unhealthy"
  invert_keyword      = true
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.public-airflow-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http_json_query" "api-http" {
  provider            = uptimekuma.public
  name                = "WebPage"
  url                 = "https://${data.terraform_remote_state.cloudflare.outputs.api_dns_record_name}/health-check/"
  json_path           = "$.status"
  expected_value      = "ok"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.api-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http_json_query" "public-databasus-http" {
  provider            = uptimekuma.public
  name                = "WebPage"
  url                 = "https://${data.terraform_remote_state.cloudflare.outputs.databasus_dns_record_name}/api/v1/system/health"
  json_path           = "$.status"
  expected_value      = "Application is healthy, internal DB working fine and disk usage is below 95%. You can connect downdetector to this endpoint"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.public-databasus-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http" "public-phpmyadmin-http" {
  provider            = uptimekuma.public
  name                = "WebPage"
  url                 = "https://${data.terraform_remote_state.cloudflare.outputs.phpmyadmin_dns_record_name}"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.public-mariadb-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http_keyword" "public-pgadmin-http" {
  provider            = uptimekuma.public
  name                = "WebPage"
  url                 = "https://${data.terraform_remote_state.cloudflare.outputs.pgadmin_dns_record_name}/misc/ping"
  keyword             = "PING"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.public-postgres-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http_json_query" "public-syncthing-http" {
  provider            = uptimekuma.public
  name                = "WebPage"
  url                 = "https://${data.terraform_remote_state.cloudflare.outputs.backup_dns_record_name}/rest/noauth/health"
  json_path           = "$.status"
  expected_value      = "OK"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.public-syncthing-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http_keyword" "public-traefik-http" {
  provider            = uptimekuma.public
  name                = "WebPage"
  url                 = "https://${data.terraform_remote_state.cloudflare.outputs.traefik_dns_record_name}/ping"
  keyword             = "OK"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.public-traefik-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http" "iowa-http" {
  provider            = uptimekuma.public
  name                = "DNS"
  url                 = "https://${data.terraform_remote_state.cloudflare.outputs.adguard_dns_record_name}"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.iowa-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_ping" "iowa-ping" {
  provider    = uptimekuma.public
  name        = "PING"
  hostname    = data.terraform_remote_state.cloudflare.outputs.iowa_vpn_dns_record_name
  interval    = 60
  max_retries = 0
  active      = false
  parent      = uptimekuma_monitor_group.iowa-group.id
}

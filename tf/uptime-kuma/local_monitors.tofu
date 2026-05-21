resource "uptimekuma_monitor_docker" "adguard-docker" {
  provider         = uptimekuma.local
  name             = "Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "adguard"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.adguard-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "airflow-triggerer-docker" {
  provider         = uptimekuma.local
  name             = "Triggerer Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "airflow-triggerer"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.airflow-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "airflow-api-server-docker" {
  provider         = uptimekuma.local
  name             = "API Server Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "airflow-api-server"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.airflow-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "airflow-dag-processor-docker" {
  provider         = uptimekuma.local
  name             = "DAG Processor Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "airflow-dag-processor"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.airflow-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "airflow-scheduler-docker" {
  provider         = uptimekuma.local
  name             = "Scheduler Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "airflow-scheduler"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.airflow-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "authentik-server-docker" {
  provider         = uptimekuma.local
  name             = "Server Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "authentik"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.authentik-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "authentik-worker-docker" {
  provider         = uptimekuma.local
  name             = "Workder Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "authentik_worker"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.authentik-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "beszel-docker" {
  provider         = uptimekuma.local
  name             = "Dashboard Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "beszel"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.beszel-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "beszel-agent-docker" {
  provider         = uptimekuma.local
  name             = "Agent Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "beszel-agent-photo-server"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.beszel-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "bitwarden-nginx-docker" {
  provider         = uptimekuma.local
  name             = "Nginx Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "bitwarden-nginx"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.bitwarden-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "bitwarden-admin-docker" {
  provider         = uptimekuma.local
  name             = "Admin Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "bitwarden-admin"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.bitwarden-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "bitwarden-identity-docker" {
  provider         = uptimekuma.local
  name             = "Identity Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "bitwarden-identity"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.bitwarden-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "bitwarden-api-docker" {
  provider         = uptimekuma.local
  name             = "API Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "bitwarden-api"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.bitwarden-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "bitwarden-events-docker" {
  provider         = uptimekuma.local
  name             = "Events Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "bitwarden-events"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.bitwarden-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "bitwarden-icons-docker" {
  provider         = uptimekuma.local
  name             = "Icons Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "bitwarden-icons"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.bitwarden-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "bitwarden-web" {
  provider         = uptimekuma.local
  name             = "Web Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "bitwarden-web"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.bitwarden-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "bitwarden-mssql-docker" {
  provider         = uptimekuma.local
  name             = "Mssql Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "bitwarden-mssql"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.bitwarden-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "bitwarden-attachments-docker" {
  provider         = uptimekuma.local
  name             = "Attachments Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "bitwarden-attachments"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.bitwarden-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "bitwarden-notifications-docker" {
  provider         = uptimekuma.local
  name             = "Notifications Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "bitwarden-notifications"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.bitwarden-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "bsn-docker" {
  provider         = uptimekuma.local
  name             = "Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "bsn"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.bsn-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "databasus-docker" {
  provider         = uptimekuma.local
  name             = "Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "databasus"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.databasus-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "forgejo-docker" {
  provider         = uptimekuma.local
  name             = "Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "forgejo"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.forgejo-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "immich-server-docker" {
  provider         = uptimekuma.local
  name             = "Server Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "immich_server"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.immich-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "immich-machine-learning-docker" {
  provider         = uptimekuma.local
  name             = "Machine Learning Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "immich_machine_learning"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.immich-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "immich-postgres-docker" {
  provider         = uptimekuma.local
  name             = "Postgres Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "immich_postgres"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.immich-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "infisical-docker" {
  provider         = uptimekuma.local
  name             = "Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "infisical-backend"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.infisical-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "mariadb-docker" {
  provider         = uptimekuma.local
  name             = "DB Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "mariadb"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.mariadb-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "phpmyadmin-docker" {
  provider         = uptimekuma.local
  name             = "PHP My Admin Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "phpmyadmin"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.mariadb-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "mend-docker" {
  provider         = uptimekuma.local
  name             = "Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "mend_renovate"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.mend-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "minecraft-docker" {
  provider         = uptimekuma.local
  name             = "Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "crafty"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.minecraft-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "n8n-docker" {
  provider         = uptimekuma.local
  name             = "Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "n8n"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.n8n-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "nextcloud-apahce-docker" {
  provider         = uptimekuma.local
  name             = "Apache Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "nextcloud-aio-apache"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.nextcloud-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "nextcloud-docker" {
  provider         = uptimekuma.local
  name             = "Nextcloud Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "nextcloud-aio-nextcloud"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.nextcloud-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "nextcloud-imaginary-docker" {
  provider         = uptimekuma.local
  name             = "Imaginary Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "nextcloud-aio-imaginary"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.nextcloud-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "nextcloud-talk-recording-docker" {
  provider         = uptimekuma.local
  name             = "Talk Recording Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "nextcloud-aio-talk-recording"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.nextcloud-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "nextcloud-fulltextsearch" {
  provider         = uptimekuma.local
  name             = "Fulltextsearch Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "nextcloud-aio-fulltextsearch"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.nextcloud-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "nextcloud-clamav-docker" {
  provider         = uptimekuma.local
  name             = "ClamAV Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "nextcloud-aio-clamav"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.nextcloud-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "nextcloud-redis-docker" {
  provider         = uptimekuma.local
  name             = "Redis Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "nextcloud-aio-redis"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.nextcloud-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "nextcloud-database-docker" {
  provider         = uptimekuma.local
  name             = "Database Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "nextcloud-aio-database"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.nextcloud-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "nextcloud-harp-docker" {
  provider         = uptimekuma.local
  name             = "Harp Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "nextcloud-aio-harp"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.nextcloud-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "nextcloud-whiteboard-docker" {
  provider         = uptimekuma.local
  name             = "Whiteboard Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "nextcloud-aio-whiteboard"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.nextcloud-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "nextcloud-notify-push-docker" {
  provider         = uptimekuma.local
  name             = "Notify Push Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "nextcloud-aio-notify-push"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.nextcloud-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "nextcloud-talk-docker" {
  provider         = uptimekuma.local
  name             = "Talk Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "nextcloud-aio-talk"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.nextcloud-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "nextcloud-collabora-docker" {
  provider         = uptimekuma.local
  name             = "Collabora Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "nextcloud-aio-collabora"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.nextcloud-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "nextcloud-mastercontainer-docker" {
  provider         = uptimekuma.local
  name             = "Mastercontainer Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "nextcloud-aio-mastercontainer"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.nextcloud-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "openspeedtest-docker" {
  provider         = uptimekuma.local
  name             = "Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "openspeedtest"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.openspeedtest-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "paperless-docker" {
  provider         = uptimekuma.local
  name             = "Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "paperless-ngx"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.paperless-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "paperless-nc-sync-docker" {
  provider         = uptimekuma.local
  name             = "Sync Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "paperless-nextcloud-sync"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.paperless-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "postgres-docker" {
  provider         = uptimekuma.local
  name             = "DB Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "postgres"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.postgres-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "pgadmin-docker" {
  provider         = uptimekuma.local
  name             = "PgAdmin Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "pgadmin"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.postgres-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "redis-docker" {
  provider         = uptimekuma.local
  name             = "Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "redis"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.redis-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "syncthing-docker" {
  provider         = uptimekuma.local
  name             = "Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "syncthing"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.syncthing-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "traefik-docker" {
  provider         = uptimekuma.local
  name             = "Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "traefik"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.traefik-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "unifi-toolkit-docker" {
  provider         = uptimekuma.local
  name             = "Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "unifi-toolkit"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.unifi-toolkit-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_docker" "wireguard-docker" {
  provider         = uptimekuma.local
  name             = "Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "wireguard"
  interval         = 60
  active           = true
  parent           = uptimekuma_monitor_group.wireguard-group.id
  max_retries      = 0
}

resource "uptimekuma_monitor_http" "adguard-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://${data.terraform_remote_state.cloudflare.outputs.adguard_dns_record_name}"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.adguard-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http_keyword" "airflow-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://airflow.${data.terraform_remote_state.adguard.outputs.local_wildcard}/api/v2/monitor/health"
  keyword             = "unhealthy"
  invert_keyword      = true
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.airflow-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http" "authentik-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://${data.terraform_remote_state.cloudflare.outputs.authentik_dns_record_name}/-/health/ready/"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.authentik-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http" "beszel-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://stats.${data.terraform_remote_state.adguard.outputs.local_wildcard}/api/health"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.beszel-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http" "bitwarden-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://${data.terraform_remote_state.cloudflare.outputs.vault_dns_record_name}/alive"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.bitwarden-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http" "databasus-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://databasus.${data.terraform_remote_state.adguard.outputs.local_wildcard}"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.databasus-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http_json_query" "forgejo-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://${data.terraform_remote_state.cloudflare.outputs.forgejo_dns_record_name}/api/healthz"
  json_path           = "$.status"
  expected_value      = "pass"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.forgejo-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http_json_query" "immich-local-http" {
  provider            = uptimekuma.local
  name                = "WebPage (Local)"
  url                 = "https://photos.${data.terraform_remote_state.adguard.outputs.local_wildcard}/api/server/ping"
  json_path           = "$.res"
  expected_value      = "pong"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.immich-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http_json_query" "immich-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://${data.terraform_remote_state.cloudflare.outputs.photos_dns_record_name}/api/server/ping"
  json_path           = "$.res"
  expected_value      = "pong"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.immich-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http" "infisical-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://${data.terraform_remote_state.cloudflare.outputs.secrets_dns_record_name}/api/status"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.infisical-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http" "phpmyadmin-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://phpmyadmin.${data.terraform_remote_state.adguard.outputs.local_wildcard}"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.mariadb-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http_keyword" "mend-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://${data.terraform_remote_state.cloudflare.outputs.mend_dns_record_name}/health"
  keyword             = "OK"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.mend-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http_json_query" "minecraft-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://${data.terraform_remote_state.cloudflare.outputs.minecraft_dns_record_name}/api/v2/crafty/check"
  json_path           = "$.status"
  expected_value      = "ok"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.minecraft-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http_json_query" "n8n-local-http" {
  provider            = uptimekuma.local
  name                = "WebPage (Local)"
  url                 = "https://n8n.${data.terraform_remote_state.adguard.outputs.local_wildcard}/healthz/readiness"
  json_path           = "$.status"
  expected_value      = "ok"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.n8n-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http_json_query" "n8n-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://${data.terraform_remote_state.cloudflare.outputs.n8n_dns_record_name}/healthz/readiness"
  json_path           = "$.status"
  expected_value      = "ok"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.n8n-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http" "nextcloud-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://${data.terraform_remote_state.cloudflare.outputs.nextcloud_dns_record_name}/status.php"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.nextcloud-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http" "nextcloud-aio-http" {
  provider            = uptimekuma.local
  name                = "WebPage (AIO)"
  url                 = "https://nextcloud-aio.${data.terraform_remote_state.adguard.outputs.local_wildcard}"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.nextcloud-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http" "openspeedtest-local-http" {
  provider            = uptimekuma.local
  name                = "WebPage (Local)"
  url                 = "https://speed.${data.terraform_remote_state.adguard.outputs.local_wildcard}"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.openspeedtest-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http" "openspeedtest-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://${data.terraform_remote_state.cloudflare.outputs.open_speedtest_dns_record_name}"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.openspeedtest-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http" "paperless-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://paperless.${data.terraform_remote_state.adguard.outputs.local_wildcard}"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.paperless-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http_keyword" "pgadmin-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://pgadmin.${data.terraform_remote_state.adguard.outputs.local_wildcard}/misc/ping"
  keyword             = "PING"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.postgres-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http_json_query" "syncthing-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://backup.${data.terraform_remote_state.adguard.outputs.local_wildcard}/rest/noauth/health"
  json_path           = "$.status"
  expected_value      = "OK"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.syncthing-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http_keyword" "traefik-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://traefik.${data.terraform_remote_state.adguard.outputs.local_wildcard}/ping"
  keyword             = "OK"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.traefik-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http" "unifi-toolkit-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://unifi-toolkit.${data.terraform_remote_state.adguard.outputs.local_wildcard}"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.unifi-toolkit-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http" "home-assistant-local-http" {
  provider            = uptimekuma.local
  name                = "WebPage (Local)"
  url                 = "https://home.${data.terraform_remote_state.adguard.outputs.local_wildcard}"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.home-assistant-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http" "home-assistant-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://${data.terraform_remote_state.cloudflare.outputs.home_dns_record_name}"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.home-assistant-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http" "pikvm-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://${data.terraform_remote_state.cloudflare.outputs.pikvm_dns_record_name}"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.pikvm-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http" "pikvm-ip-http" {
  provider     = uptimekuma.local
  name         = "WebPage (IP)"
  url          = "https://192.168.1.24"
  cache_buster = true
  ignore_tls   = true
  interval     = 60
  active       = true
  parent       = uptimekuma_monitor_group.pikvm-group.id
  max_retries  = 0
}

resource "uptimekuma_monitor_http" "proxmox-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://proxmox.${data.terraform_remote_state.adguard.outputs.local_wildcard}"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.proxmox-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http" "proxmox-ip-http" {
  provider     = uptimekuma.local
  name         = "WebPage (IP)"
  url          = "https://192.168.1.18:8006"
  cache_buster = true
  ignore_tls   = true
  interval     = 60
  active       = true
  parent       = uptimekuma_monitor_group.proxmox-group.id
  max_retries  = 0
}

resource "uptimekuma_monitor_http" "synology-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://${data.terraform_remote_state.cloudflare.outputs.synology_dns_record_name}"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.synology-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http" "proxmox-local-http" {
  provider            = uptimekuma.local
  name                = "WebPage (Local)"
  url                 = "https://nas.${data.terraform_remote_state.adguard.outputs.local_wildcard}"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.synology-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http" "synology-ip-http" {
  provider     = uptimekuma.local
  name         = "WebPage (IP)"
  url          = "https://192.168.1.133:5001"
  cache_buster = true
  ignore_tls   = true
  interval     = 60
  active       = true
  parent       = uptimekuma_monitor_group.synology-group.id
  max_retries  = 0
}

resource "uptimekuma_monitor_http" "unifi-http" {
  provider            = uptimekuma.local
  name                = "WebPage"
  url                 = "https://unifi.${data.terraform_remote_state.adguard.outputs.local_wildcard}"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.unifi-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http_json_query" "racknerd-http" {
  provider            = uptimekuma.local
  name                = "API"
  url                 = "https://${data.terraform_remote_state.cloudflare.outputs.api_dns_record_name}/health-check/"
  json_path           = "$.status"
  expected_value      = "ok"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.racknerd-group.id
  max_retries         = 0
}

resource "uptimekuma_monitor_ping" "racknerd-ping" {
  provider    = uptimekuma.local
  name        = "PING"
  hostname    = data.terraform_remote_state.cloudflare.outputs.vpn_dns_record_name
  interval    = 60
  max_retries = 0
  active      = true
  parent      = uptimekuma_monitor_group.racknerd-group.id
}

resource "uptimekuma_monitor_http_keyword" "youtube-livestream" {
  provider            = uptimekuma.local
  name                = "Livestream"
  url                 = "https://www.youtube.com/feeds/videos.xml?playlist_id=UULVXuqSBlHAE6Xw-yeJA0Tunw"
  keyword             = "Linus Tech Tips"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.youtube-rss.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http_keyword" "youtube-video" {
  provider            = uptimekuma.local
  name                = "Video"
  url                 = "https://www.youtube.com/feeds/videos.xml?playlist_id=UULFXuqSBlHAE6Xw-yeJA0Tunw"
  keyword             = "Linus Tech Tips"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.youtube-rss.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http_keyword" "youtube-short" {
  provider            = uptimekuma.local
  name                = "Short"
  url                 = "https://www.youtube.com/feeds/videos.xml?playlist_id=UUSHXuqSBlHAE6Xw-yeJA0Tunw"
  keyword             = "Linus Tech Tips"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.youtube-rss.id
  max_retries         = 0
}

resource "uptimekuma_monitor_http_keyword" "youtube-channel" {
  provider            = uptimekuma.local
  name                = "Channel"
  url                 = "https://www.youtube.com/feeds/videos.xml?channel_id=UCXuqSBlHAE6Xw-yeJA0Tunw"
  keyword             = "Linus Tech Tips"
  cache_buster        = true
  expiry_notification = true
  interval            = 60
  active              = true
  parent              = uptimekuma_monitor_group.youtube-rss.id
  max_retries         = 0
}

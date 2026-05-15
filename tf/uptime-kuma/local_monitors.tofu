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

resource "uptimekuma_monitor_docker" "authentik-proxy-docker" {
  provider         = uptimekuma.local
  name             = "Proxy Container"
  docker_host_id   = uptimekuma_docker_host.local_socket.id
  docker_container = "ak-outpost-traefik-output"
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
  parent           = uptimekuma_monitor_group.infiscal-group.id
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

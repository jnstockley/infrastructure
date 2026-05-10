resource "infisical_project" "infrastructure" {
  name        = "infrastructure"
  slug        = "infrastructure"
  description = "GitHub infrastructure secrets"
  type        = "secret-manager" # Default project type
}

resource "infisical_project_environment" "racknerd" {
  name       = "Rackerd"
  project_id = infisical_project.infrastructure.id
  slug       = "racknerd"
}

resource "infisical_project_environment" "photo-server" {
  name       = "Photo Server"
  project_id = infisical_project.infrastructure.id
  slug       = "photo-server"
}

resource "infisical_project" "bsn" {
  name        = "bsn"
  slug        = "bsn"
  description = "GitHub bsn secrets"
  type        = "secret-manager" # Default project type
}

resource "infisical_project" "email-to-calendar" {
  name        = "email-to-calendar"
  slug        = "email-to-calendar"
  description = "GitHub email-to-calendar secrets"
  type        = "secret-manager" # Default project type
}

resource "infisical_project" "poetry" {
  name        = "poetry"
  slug        = "poetry"
  description = "GitHub poetry secrets"
  type        = "secret-manager" # Default project type
}

resource "infisical_project" "api" {
  name        = "api"
  slug        = "api"
  description = "GitHub api secrets"
  type        = "secret-manager" # Default project type
}

resource "infisical_project" "airflow" {
  name        = "airflow"
  slug        = "airflow"
  description = "GitHub airflow secrets"
  type        = "secret-manager" # Default project type
}

resource "infisical_project" "web-scraper" {
  name        = "web-scraper"
  slug        = "web-scraper"
  description = "GitHub web-scraper secrets"
  type        = "secret-manager" # Default project type
}

resource "infisical_project" "secret-santa" {
  name        = "secret-santa"
  slug        = "secret-santa"
  description = "GitHub secret-santa secrets"
  type        = "secret-manager" # Default project type
}

resource "infisical_project" "python-starter" {
  name        = "python-starter"
  slug        = "python-starter"
  description = "GitHub python-starter secrets"
  type        = "secret-manager" # Default project type
}

resource "infisical_project" "govee-cloud" {
  name        = "govee-cloud"
  slug        = "govee-cloud"
  description = "GitHub govee-cloud secrets"
  type        = "secret-manager" # Default project type
}

resource "infisical_project" "open-tofu" {
  name        = "OpenTofu"
  slug        = "open-tofu"
  description = "OpenTofu secrets"
  type        = "secret-manager" # Default project type
}

resource "infisical_project_environment" "adguard" {
  name       = "AdGuard"
  project_id = infisical_project.open-tofu.id
  slug       = "adguard"
}

resource "infisical_project_environment" "authentik" {
  name       = "Authentik"
  project_id = infisical_project.open-tofu.id
  slug       = "authentik"
}

resource "infisical_project_environment" "cloudflare" {
  name       = "Cloudflare"
  project_id = infisical_project.open-tofu.id
  slug       = "cloudflare"
}

resource "infisical_project_environment" "gitea" {
  name       = "Gitea"
  project_id = infisical_project.open-tofu.id
  slug       = "gitea"
}

resource "infisical_project_environment" "infisical" {
  name       = "Infisical"
  project_id = infisical_project.open-tofu.id
  slug       = "infisical"
}

resource "infisical_project_environment" "proxmox" {
  name       = "Proxmox"
  project_id = infisical_project.open-tofu.id
  slug       = "proxmox"
}

resource "infisical_project_environment" "unifi" {
  name       = "Unifi"
  project_id = infisical_project.open-tofu.id
  slug       = "unifi"
}

resource "infisical_project_environment" "uptime-kuma" {
  name       = "Uptime Kuma"
  project_id = infisical_project.open-tofu.id
  slug       = "uptime-kuma"
}


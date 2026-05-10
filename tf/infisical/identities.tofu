resource "infisical_identity" "infrastructure-identity" {
  name   = "GitHub Infrastructure"
  role   = "no-access"
  org_id = "668742a7-11b2-484e-9e4e-684fcbbcb304"
}

resource "infisical_identity_oidc_auth" "infrastructure-oidc-auth" {
  identity_id        = infisical_identity.infrastructure-identity.id
  oidc_discovery_url = "https://token.actions.githubusercontent.com"
  bound_issuer       = "https://token.actions.githubusercontent.com"
  bound_audiences    = ["https://github.com/jnstockley"]
  bound_subject      = "repo:jnstockley/infrastructure:environment:(racknerd|photo-server)"
}

resource "infisical_project_identity" "infrastructure-project-identity" {
  project_id  = infisical_project.infrastructure.id
  identity_id = infisical_identity.infrastructure-identity.id
  roles = [
    {
      role_slug = "viewer"
    }
  ]
}

resource "infisical_identity" "python-starter-identity" {
  name   = "GitHub python-starter"
  role   = "no-access"
  org_id = "668742a7-11b2-484e-9e4e-684fcbbcb304"
}

resource "infisical_identity_oidc_auth" "python-starter-oidc-auth" {
  identity_id        = infisical_identity.python-starter-identity.id
  oidc_discovery_url = "https://token.actions.githubusercontent.com"
  bound_issuer       = "https://token.actions.githubusercontent.com"
  bound_audiences    = ["https://github.com/jnstockley"]
  bound_subject      = "repo:jnstockley/python-starter:environment:docker"
}

resource "infisical_project_identity" "python-starter-project-identity" {
  project_id  = infisical_project.python-starter.id
  identity_id = infisical_identity.python-starter-identity.id
  roles = [
    {
      role_slug = "viewer"
    }
  ]
}

resource "infisical_identity" "airflow-identity" {
  name   = "GitHub airflow"
  role   = "no-access"
  org_id = "668742a7-11b2-484e-9e4e-684fcbbcb304"
}

resource "infisical_identity_oidc_auth" "airflow-oidc-auth" {
  identity_id        = infisical_identity.airflow-identity.id
  oidc_discovery_url = "https://token.actions.githubusercontent.com"
  bound_issuer       = "https://token.actions.githubusercontent.com"
  bound_audiences    = ["https://github.com/jnstockley"]
  bound_subject      = "repo:jnstockley/airflow:environment:docker"
}

resource "infisical_project_identity" "airflow-project-identity" {
  project_id  = infisical_project.airflow.id
  identity_id = infisical_identity.airflow-identity.id
  roles = [
    {
      role_slug = "viewer"
    }
  ]
}

resource "infisical_identity" "api-identity" {
  name   = "GitHub api"
  role   = "no-access"
  org_id = "668742a7-11b2-484e-9e4e-684fcbbcb304"
}

resource "infisical_identity_oidc_auth" "api-oidc-auth" {
  identity_id        = infisical_identity.api-identity.id
  oidc_discovery_url = "https://token.actions.githubusercontent.com"
  bound_issuer       = "https://token.actions.githubusercontent.com"
  bound_audiences    = ["https://github.com/jnstockley"]
  bound_subject      = "repo:jnstockley/api:environment:(docker|sync)"
}

resource "infisical_project_identity" "api-project-identity" {
  project_id  = infisical_project.api.id
  identity_id = infisical_identity.api-identity.id
  roles = [
    {
      role_slug = "viewer"
    }
  ]
}

resource "infisical_identity" "bsn-identity" {
  name   = "GitHub bsn"
  role   = "no-access"
  org_id = "668742a7-11b2-484e-9e4e-684fcbbcb304"
}

resource "infisical_identity_oidc_auth" "bsn-oidc-auth" {
  identity_id        = infisical_identity.bsn-identity.id
  oidc_discovery_url = "https://token.actions.githubusercontent.com"
  bound_issuer       = "https://token.actions.githubusercontent.com"
  bound_audiences    = ["https://github.com/jnstockley"]
  bound_subject      = "repo:jnstockley/bsn:environment:(docker|sync)"
}

resource "infisical_project_identity" "bsn-project-identity" {
  project_id  = infisical_project.bsn.id
  identity_id = infisical_identity.bsn-identity.id
  roles = [
    {
      role_slug = "viewer"
    }
  ]
}

resource "infisical_identity" "email-to-calendar-identity" {
  name   = "GitHub email-to-calendar"
  role   = "no-access"
  org_id = "668742a7-11b2-484e-9e4e-684fcbbcb304"
}

resource "infisical_identity_oidc_auth" "email-to-calendar-oidc-auth" {
  identity_id        = infisical_identity.email-to-calendar-identity.id
  oidc_discovery_url = "https://token.actions.githubusercontent.com"
  bound_issuer       = "https://token.actions.githubusercontent.com"
  bound_audiences    = ["https://github.com/jnstockley"]
  bound_subject      = "repo:jnstockley/email-to-calendar:environment:(docker|sync)"
}

resource "infisical_project_identity" "email-to-calendar-project-identity" {
  project_id  = infisical_project.email-to-calendar.id
  identity_id = infisical_identity.email-to-calendar-identity.id
  roles = [
    {
      role_slug = "viewer"
    }
  ]
}

resource "infisical_identity" "poetry-identity" {
  name   = "GitHub poetry"
  role   = "no-access"
  org_id = "668742a7-11b2-484e-9e4e-684fcbbcb304"
}

resource "infisical_identity_oidc_auth" "poetry-oidc-auth" {
  identity_id        = infisical_identity.poetry-identity.id
  oidc_discovery_url = "https://token.actions.githubusercontent.com"
  bound_issuer       = "https://token.actions.githubusercontent.com"
  bound_audiences    = ["https://github.com/jnstockley"]
  bound_subject      = "repo:jnstockley/poetry:*"
}

resource "infisical_project_identity" "poetry-project-identity" {
  project_id  = infisical_project.poetry.id
  identity_id = infisical_identity.poetry-identity.id
  roles = [
    {
      role_slug = "viewer"
    }
  ]
}

resource "infisical_identity" "secret-santa-identity" {
  name   = "GitHub secret-santa"
  role   = "no-access"
  org_id = "668742a7-11b2-484e-9e4e-684fcbbcb304"
}

resource "infisical_identity_oidc_auth" "secret-santa-oidc-auth" {
  identity_id        = infisical_identity.secret-santa-identity.id
  oidc_discovery_url = "https://token.actions.githubusercontent.com"
  bound_issuer       = "https://token.actions.githubusercontent.com"
  bound_audiences    = ["https://github.com/jnstockley"]
  bound_subject      = "repo:jnstockley/secret-santa:environment:(docker|sync)"
}

resource "infisical_project_identity" "secret-santa-project-identity" {
  project_id  = infisical_project.secret-santa.id
  identity_id = infisical_identity.secret-santa-identity.id
  roles = [
    {
      role_slug = "viewer"
    }
  ]
}

resource "infisical_identity" "web-scraper-identity" {
  name   = "GitHub web-scraper"
  role   = "no-access"
  org_id = "668742a7-11b2-484e-9e4e-684fcbbcb304"
}

resource "infisical_identity_oidc_auth" "web-scraper-oidc-auth" {
  identity_id        = infisical_identity.web-scraper-identity.id
  oidc_discovery_url = "https://token.actions.githubusercontent.com"
  bound_issuer       = "https://token.actions.githubusercontent.com"
  bound_audiences    = ["https://github.com/jnstockley"]
  bound_subject      = "repo:jnstockley/web-scraper:environment:(docker|sync)"
}

resource "infisical_project_identity" "web-scraper-project-identity" {
  project_id  = infisical_project.web-scraper.id
  identity_id = infisical_identity.web-scraper-identity.id
  roles = [
    {
      role_slug = "viewer"
    }
  ]
}

resource "infisical_identity" "govee-cloud-identity" {
  name   = "GitHub govee-cloud"
  role   = "no-access"
  org_id = "668742a7-11b2-484e-9e4e-684fcbbcb304"
}

resource "infisical_identity_oidc_auth" "govee-cloud-oidc-auth" {
  identity_id        = infisical_identity.govee-cloud-identity.id
  oidc_discovery_url = "https://token.actions.githubusercontent.com"
  bound_issuer       = "https://token.actions.githubusercontent.com"
  bound_audiences    = ["https://github.com/jnstockley"]
  bound_subject      = "repo:jnstockley/govee-cloud:environment:(docker|sync)"
}

resource "infisical_project_identity" "govee-cloud-project-identity" {
  project_id  = infisical_project.govee-cloud.id
  identity_id = infisical_identity.govee-cloud-identity.id
  roles = [
    {
      role_slug = "viewer"
    }
  ]
}

resource "infisical_identity" "open-tofu-identity" {
  name   = "OpenTofu"
  role   = "no-access"
  org_id = "668742a7-11b2-484e-9e4e-684fcbbcb304"
}

resource "infisical_identity_oidc_auth" "open-tofu-oidc-auth" {
  identity_id        = infisical_identity.open-tofu-identity.id
  oidc_discovery_url = "https://token.actions.githubusercontent.com"
  bound_issuer       = "https://token.actions.githubusercontent.com"
  bound_audiences    = ["https://github.com/jnstockley"]
  bound_subject      = "repo:jnstockley/infrastructure:environment:(adguard|authentik|cloudflare|gitea|infisical|proxmox|unifi|uptime-kuma)"
}

resource "infisical_project_identity" "open-tofu-project-identity" {
  project_id  = infisical_project.open-tofu.id
  identity_id = infisical_identity.open-tofu-identity.id
  roles = [
    {
      role_slug = "viewer"
    }
  ]
}

terraform {
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "2026.2.0"
    }
  }

  backend "http" {

  }
}

data "terraform_remote_state" "cloudflare" {
  backend = "http"

  config = {
    address  = "https://gitlab.com/api/v4/projects/75895281/terraform/state/cloudflare"
    username = var.gitlab_username
    password = var.gitlab_access_token
  }
}

data "terraform_remote_state" "adguard" {
  backend = "http"

  config = {
    address  = "https://gitlab.com/api/v4/projects/75895281/terraform/state/adguard"
    username = var.gitlab_username
    password = var.gitlab_access_token
  }
}

variable "authentik_api_token" {
  type      = string
  sensitive = true
}

provider "authentik" {
  url   = "https://${data.terraform_remote_state.cloudflare.outputs.authentik_dns_record_name}"
  token = var.authentik_api_token
}

variable "gitlab_username" {
  type      = string
  sensitive = false
}

variable "gitlab_access_token" {
  type      = string
  sensitive = true
}

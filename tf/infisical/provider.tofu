terraform {
  required_providers {
    infisical = {
      source  = "Infisical/infisical"
      version = "0.16.30"
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

variable "gitlab_username" {
  type      = string
  sensitive = false
}

variable "gitlab_access_token" {
  type      = string
  sensitive = true
}

variable "infisical_client_id" {
  type      = string
  sensitive = false
}

variable "infisical_client_secret" {
  type      = string
  sensitive = true
}

provider "infisical" {
  host = "https://${data.terraform_remote_state.cloudflare.outputs.secrets_dns_record_name}"
  auth = {
    universal = {
      client_id     = var.infisical_client_id
      client_secret = var.infisical_client_secret
    }
  }
}

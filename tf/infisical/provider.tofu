terraform {
  required_providers {
    infisical = {
      source  = "Infisical/infisical"
      version = "0.16.21"
    }
  }

  backend "http" {

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
  host = "https://secrets.jstockley.com"
  auth = {
    universal = {
      client_id     = var.infisical_client_id
      client_secret = var.infisical_client_secret
    }
  }
}

terraform {
  required_providers {
    tailscale = {
      source  = "tailscale/tailscale"
      version = "0.29.2"
    }
  }

  backend "http" {}
}

variable "oauth_client_id" {
  type      = string
  sensitive = false
}

variable "oauth_client_secret" {
  type      = string
  sensitive = true
}

provider "tailscale" {
  oauth_client_id     = var.oauth_client_id
  oauth_client_secret = var.oauth_client_secret
  tailnet             = "jstockley.com"
}

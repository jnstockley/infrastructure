terraform {
  required_providers {
    adguard = {
      source  = "gmichels/adguard"
      version = "1.6.2"
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

variable "adguard_username" {
  type = string
}

variable "adguard_password" {
  type      = string
  sensitive = true
}

variable "gitlab_username" {
  type      = string
  sensitive = false
}

variable "gitlab_access_token" {
  type      = string
  sensitive = true
}

provider "adguard" {
  host     = data.terraform_remote_state.cloudflare.outputs.adguard_dns_record_name
  scheme   = "https"
  username = var.adguard_username
  password = var.adguard_password
}

terraform {
  required_providers {
    unifi = {
      source  = "ubiquiti-community/unifi"
      version = "0.54.0"
    }
  }

  backend "http" {

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

variable "unifi_api_key" {
  type      = string
  sensitive = true
}

variable "gitlab_username" {
  type = string
}

variable "gitlab_access_token" {
  type      = string
  sensitive = true
}

variable "wifi_passphrase" {
  type      = string
  sensitive = true
}

provider "unifi" {
  api_url = "https://unifi.${data.terraform_remote_state.adguard.outputs.local_wildcard}"
  api_key = var.unifi_api_key
}
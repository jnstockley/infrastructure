terraform {
  required_providers {
    uptimekuma = {
      source  = "breml/uptimekuma"
      version = "0.3.2"
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

variable "smtp_password" {
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

variable "uptime_kuma_local_username" {
  type = string
}

variable "uptime_kuma_public_username" {
  type = string
}

variable "uptime_kuma_local_password" {
  type      = string
  sensitive = true
}

variable "uptime_kuma_public_password" {
  type      = string
  sensitive = true
}

variable "nextcloud_talk_conversation_token" {
  type      = string
  sensitive = true
}

variable "nextcloud_talk_local_secret" {
  type      = string
  sensitive = true
}

variable "nextcloud_talk_public_secret" {
  type      = string
  sensitive = true
}

provider "uptimekuma" {
  alias    = "local"
  endpoint = "https://status.${data.terraform_remote_state.adguard.outputs.local_wildcard}"
  username = var.uptime_kuma_local_username
  password = var.uptime_kuma_local_password
}

provider "uptimekuma" {
  alias    = "public"
  endpoint = "https://${data.terraform_remote_state.cloudflare.outputs.status_dns_record_name}"
  username = var.uptime_kuma_public_username
  password = var.uptime_kuma_public_password
}

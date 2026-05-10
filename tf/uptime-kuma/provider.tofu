terraform {
  required_providers {
    uptimekuma = {
      source  = "breml/uptimekuma"
      version = "0.3.0"
    }
  }

  backend "http" {

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

variable "uptime_kuma_local_endpoint" {
  type = string
}

variable "uptime_kuma_public_endpoint" {
  type = string
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

variable "nextcloud_talk_local_conversation_token" {
  type      = string
  sensitive = true
}

variable "nextcloud_talk_local_secret" {
  type      = string
  sensitive = true
}

provider "uptimekuma" {
  alias    = "local"
  endpoint = var.uptime_kuma_local_endpoint
  username = var.uptime_kuma_local_username
  password = var.uptime_kuma_local_password

}

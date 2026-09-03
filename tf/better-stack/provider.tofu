terraform {
  required_providers {
    betteruptime = {
      source  = "BetterStackHQ/better-uptime"
      version = ">= 0.21.14"
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
  type = string
}

variable "gitlab_access_token" {
  type      = string
  sensitive = true
}

variable "better_stack_api_key" {
  type      = string
  sensitive = true
}


provider "betteruptime" {
  api_token = var.better_stack_api_key
}
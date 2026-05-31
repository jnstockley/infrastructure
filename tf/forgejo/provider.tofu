terraform {
  required_providers {
    forgejo = {
      source  = "svalabs/forgejo"
      version = "1.5.0"
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

variable "forgejo_token" {
  type      = string
  sensitive = true
}

variable "github_token" {
  type      = string
  sensitive = true
}

variable "research_git_token" {
  type      = string
  sensitive = true
}

variable "forgejo_password" {
  type      = string
  sensitive = true
}

provider "forgejo" {
  host      = "https://${data.terraform_remote_state.cloudflare.outputs.forgejo_dns_record_name}"
  api_token = var.forgejo_token
}
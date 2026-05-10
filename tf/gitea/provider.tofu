terraform {
  required_providers {
    gitea = {
      source  = "go-gitea/gitea"
      version = "0.7.0"
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

variable "gitea_token" {
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


variable "gitea_password" {
  type      = string
  sensitive = true
}

provider "gitea" {
  base_url = "https://${data.terraform_remote_state.cloudflare.outputs.gitea_dns_record_name}"
  token    = var.gitea_token
}
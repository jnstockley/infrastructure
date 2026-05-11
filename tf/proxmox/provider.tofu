terraform {
  required_version = ">= 1.9.0"

  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc07"
    }
  }

  backend "http" {}
}

data "terraform_remote_state" "adguard" {
  backend = "http"

  config = {
    address  = "https://gitlab.com/api/v4/projects/75895281/terraform/state/adguard"
    username = var.gitlab_username
    password = var.gitlab_access_token
  }
}

variable "proxmox_api_user" {
  type      = string
  sensitive = true
}

variable "proxmox_api_password" {
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

provider "proxmox" {
  pm_api_url      = "https://proxmox.${data.terraform_remote_state.adguard.outputs.local_wildcard}/api2/json"
  pm_user         = var.proxmox_api_user
  pm_password     = var.proxmox_api_password
  pm_tls_insecure = false
}
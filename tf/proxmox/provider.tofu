terraform {
  required_version = ">= 1.9.0"

  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
}

variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_user" {
  type      = string
  sensitive = true
}

variable "proxmox_api_password" {
  type      = string
  sensitive = true
}

variable "proxmox_api_otp" {
  type      = string
  sensitive = true
}


provider "proxmox" {
  pm_api_url      = var.proxmox_api_url
  pm_user         = var.proxmox_api_user
  pm_password     = var.proxmox_api_password
  pm_otp          = var.proxmox_api_otp
  pm_tls_insecure = false
}
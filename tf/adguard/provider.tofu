terraform {
  required_providers {
    adguard = {
      source  = "gmichels/adguard"
      version = "1.5.0"
    }
  }
}

variable "adguard_host" {
  type = string
}

variable "adguard_username" {
  type = string
}

variable "adguard_password" {
  type      = string
  sensitive = true
}

variable "adguard_cert_chain" {
  type      = string
  sensitive = true
}

variable "adguard_private_key" {
  type      = string
  sensitive = true
}

provider "adguard" {
  host     = var.adguard_host
  username = var.adguard_username
  password = var.adguard_password
}
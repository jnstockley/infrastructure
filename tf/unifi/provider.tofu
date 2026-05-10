terraform {
  required_providers {
    unifi = {
      source  = "ubiquiti-community/unifi"
      version = "0.41.25"
    }
  }

  backend "http" {

  }
}

variable "unifi_username" {
  type      = string
  sensitive = false
}

variable "unifi_password" {
  type      = string
  sensitive = true
}

variable "unifi_url" {
  type      = string
  sensitive = true
}


provider "unifi" {
  username = var.unifi_username
  password = var.unifi_password
  api_url  = var.unifi_url
}
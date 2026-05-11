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

variable "unifi_api_key" {
  type      = string
  sensitive = true
}

variable "unifi_url" {
  type      = string
  sensitive = true
}


provider "unifi" {
  api_url  = var.unifi_url
  api_key  = var.unifi_api_key
}
locals {
  api_base_url = "https://api.jstockley.com"
}

data "http" "racknerd_ip" {
  url = "${local.api_base_url}/ip/racknerd"

  # Optional request headers
  request_headers = {
    x-api-key = var.jstockley_api_key
  }

  lifecycle {
    postcondition {
      condition     = contains([200], self.status_code)
      error_message = "Status code invalid"
    }
  }
}

data "http" "iowa_ip" {
  url = "${local.api_base_url}/ip/iowa"

  # Optional request headers
  request_headers = {
    x-api-key = var.jstockley_api_key
  }

  lifecycle {
    postcondition {
      condition     = contains([200], self.status_code)
      error_message = "Status code invalid"
    }
  }
}

data "http" "chicago_ip" {
  url = "${local.api_base_url}/ip/chicago"

  # Optional request headers
  request_headers = {
    x-api-key = var.jstockley_api_key
  }

  lifecycle {
    postcondition {
      condition     = contains([200], self.status_code)
      error_message = "Status code invalid"
    }
  }
}

data "http" "racknerd_ip" {
  url = "${cloudflare_dns_record.api.name}/ip/racknerd"

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
  url = "${cloudflare_dns_record.api.name}/ip/iowa"

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
  url = "${cloudflare_dns_record.api.name}/ip/chicago"

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

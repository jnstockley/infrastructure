data "http" "racknerd_ip" {
  depends_on = [cloudflare_dns_record.api]
  url        = "${cloudflare_dns_record.api.name}/ip/racknerd"

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
  depends_on = [cloudflare_dns_record.api]
  url        = "${cloudflare_dns_record.api.name}/ip/iowa"

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
  depends_on = [cloudflare_dns_record.api]
  url        = "${cloudflare_dns_record.api.name}/ip/chicago"

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

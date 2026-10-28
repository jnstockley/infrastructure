# Keep existing DHCP reservations and client identities used by network policies.
# network_id is intentionally omitted: the controller has no explicit binding.
# This also avoids a cycle with networks that advertise the photo server as DNS.
resource "unifi_client" "photo_server" {
  mac      = "bc:24:11:c1:69:d7"
  name     = "Photo Server"
  fixed_ip = "192.168.1.135"
}

resource "unifi_client" "air_quality_monitor" {
  mac      = "cc:b5:d1:31:7c:fd"
  name     = "Air Quality Monitor"
  fixed_ip = "192.168.2.85"
}

resource "unifi_client" "lg_tv" {
  mac      = "80:5b:65:ca:29:0c"
  fixed_ip = "192.168.2.71"
}

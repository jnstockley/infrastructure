resource "unifi_client_qos_rate" "default" {
  name = "Default"
  # Preserve imported unlimited rates (-1). The provider rejects -1 in config.
}

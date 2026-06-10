resource "adguard_client" "tlc-tv" {
  name                        = "TLC TV"
  ids                         = ["192.168.1.128"]
  use_global_blocked_services = false
  use_global_settings         = false
}

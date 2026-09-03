resource "adguard_client" "tcl-tv" {
  name                        = "TCL TV"
  ids                         = ["192.168.1.128", "tcl-tv"]
  use_global_blocked_services = false
  use_global_settings         = true
}

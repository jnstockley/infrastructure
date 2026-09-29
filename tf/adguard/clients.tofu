resource "adguard_client" "tcl-tv" {
  name                        = "TCL TV"
  ids                         = ["192.168.1.128", "tcl-tv"]
  use_global_blocked_services = false
  use_global_settings         = true
  tags                        = ["device_tv", "os_android"]
}

resource "adguard_client" "jack-iphone" {
  name = "Jack iPhone"
  ids  = ["jack-iphone"]
  tags = ["device_phone", "os_ios"]
}

resource "adguard_client" "jack-ipad" {
  name = "Jack iPad"
  ids  = ["jack-ipad"]
  tags = ["device_tablet", "os_ios"]
}

resource "adguard_client" "jack-macbook" {
  name = "Jack MacBook"
  ids  = ["jack-macbook"]
  tags = ["device_laptop", "os_macos"]
}

resource "adguard_client" "family-room-apple-tv" {
  name = "Family Room Apple TV"
  ids  = ["family-room-apple-tv"]
  tags = ["device_tv"]
}

resource "adguard_client" "home-assistant" {
  name = "Home Assistant"
  ids  = ["192.168.1.119", "home-assistant"]
  tags = ["os_linux"]
}

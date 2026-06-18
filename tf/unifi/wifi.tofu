resource "unifi_wlan" "wifi" {
  name       = "Just One Byte"
  passphrase = var.wifi_passphrase
  security   = "wpapsk"

  # enable WPA2/WPA3 support
  wpa3_support    = true
  wpa3_transition = true
  pmf_mode        = "optional"

  network_id    = unifi_network.default.id
  ap_group_ids  = ["692ce189a40eb661dbe8c467"]
  user_group_id = "692ce188a40eb661dbe8c462"

  bss_transition            = true
  group_rekey               = 0
  minimum_data_rate_2g_kbps = 1000
  minimum_data_rate_5g_kbps = 6000
  wlan_band                 = "5g"
  wlan_bands                = ["6g", "5g"]
}

# The controller's built-in group is read-only and automatically includes all APs.
data "unifi_ap_group" "all" {
  name = "All APs"
}

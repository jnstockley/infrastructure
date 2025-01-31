resource "proxmox_vm_qemu" "debian-12" {
  name = "debian-12"
  desc = "Debian 12"
  agent = 1
  target_node = "pve" # TODO Might need to be updated
  vmid = 901 # TODO Update once tested
  onboot = true
  startup = "order=1"
  automatic_reboot = true
  qemu_os = "l26"


}
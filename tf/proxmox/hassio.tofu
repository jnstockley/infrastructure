resource "proxmox_vm_qemu" "haaio" {
  name             = "hassio"
  target_node      = "proxmox"
  vmid             = 101
  desc             = "Home Assistant"
  bios             = "ovmf"
  onboot           = true
  startup          = "order=any"
  vm_state         = "running"
  protection       = true
  boot             = "order:virtio1:virtio0"
  agent            = 1
  qemu_os          = "l26"
  memory           = 8192
  sockets          = 1
  cores            = 4
  cpu_type         = "host"
  hotplug          = "network,disk,usb"
  nameserver       = "192.168.0.1"
  automatic_reboot = true
}
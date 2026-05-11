resource "proxmox_vm_qemu" "haaio" {
  name               = "hassio"
  target_node        = "proxmox"
  vmid               = 101
  description        = "Home Assistant"
  bios               = "ovmf"
  start_at_node_boot = true
  startup_shutdown {
    order = 3
  }

  vm_state   = "running"
  protection = true
  boot       = "order:virtio1:virtio0"
  agent      = 1
  qemu_os    = "l26"
  memory     = 8192
  cpu {
    sockets = 1
    cores   = 4
    type    = "host"
  }
  hotplug          = "network,disk,usb"
  nameserver       = "192.168.0.1"
  automatic_reboot = true
}
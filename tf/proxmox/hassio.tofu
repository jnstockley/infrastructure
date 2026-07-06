resource "proxmox_vm_qemu" "hassio" {
  agent = 1
  bios  = "ovmf"
  boot  = "order=scsi0"
  cpu {
    type    = "host"
    sockets = 1
    cores   = 4
  }
  define_connection_info = false
  description            = "Home Assistant OS VM"
  full_clone             = false
  machine                = "q35"
  memory                 = 8192
  name                   = "hassio"
  qemu_os                = "l26"
  scsihw                 = "virtio-scsi-single"
  target_nodes           = ["proxmox"]
  start_at_node_boot     = true
  vmid                   = 102

  disks {
    scsi {
      scsi0 {
        disk {
          discard   = true
          iothread  = true
          replicate = true
          size      = "64G"
          storage   = "local-lvm"
        }
      }
    }
  }

  network {
    bridge   = "vmbr0"
    firewall = true
    id       = 0
    model    = "virtio"
  }

  startup_shutdown {
    order            = 3
    shutdown_timeout = 0
    startup_delay    = 0
  }

    lifecycle {
    prevent_destroy = true
  }
}
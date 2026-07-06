resource "proxmox_vm_qemu" "debian-12" {
  agent = 1
  bios  = "seabios"
  boot  = "order=virtio0;ide0"
  cpu {
    type    = "host"
    sockets = 1
    cores   = 6
  }
  define_connection_info = false
  description            = "Debian 12 VM"
  full_clone             = false
  machine                = "q35"
  memory                 = 49152
  name                   = "debian-12"
  qemu_os                = "l26"
  scsihw                 = "virtio-scsi-single"
  target_nodes           = ["proxmox"]
  start_at_node_boot     = true
  vmid                   = 100

  disks {
    ide {
      ide0 {
        cdrom {
          iso = "local:iso/debian-amd64-netinst.iso"
        }
      }
    }
    virtio {
      virtio0 {
        passthrough {
          file      = "/dev/disk/by-id/wwn-0x5002538d41e14f59"
          replicate = true
        }
      }
      virtio1 {
        passthrough {
          file      = "/dev/disk/by-id/wwn-0x5001b448b02ee912"
          replicate = true
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
    order            = 1
    shutdown_timeout = 0
    startup_delay    = 0
  }

  lifecycle {
    prevent_destroy = true
  }
}
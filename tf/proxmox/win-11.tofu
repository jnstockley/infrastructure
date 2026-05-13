resource "proxmox_vm_qemu" "win-11" {
  agent = 1
  bios  = "ovmf"
  boot  = "order=virtio0;ide0"
  cpu {
    type    = "host"
    sockets = 1
    cores   = 4
  }
  define_connection_info = false
  description            = "Windows 11 VM"
  full_clone             = false
  machine                = "pc-q35-9.0"
  memory                 = 12288
  name                   = "win-11"
  scsihw                 = "virtio-scsi-single"
  target_nodes           = ["proxmox"]
  start_at_node_boot     = true
  vmid                   = 101

  disks {
    ide {
      ide0 {
        cdrom {
          iso = "local:iso/windows-11.iso"
        }
      }
    }
    virtio {
      virtio0 {
        passthrough {
          file      = "/dev/disk/by-id/wwn-0x5000c5003ea177e3"
          replicate = true
        }
      }
      virtio1 {
        passthrough {
          file      = "/dev/disk/by-id/wwn-0x5000c500e6255bfa"
          replicate = true
        }
      }
      virtio2 {
        passthrough {
          file      = "/dev/disk/by-id/wwn-0x5000c500e60e4bd8"
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
    order            = 2
    shutdown_timeout = 0
    startup_delay    = 0
  }
}
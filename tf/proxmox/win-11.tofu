resource "proxmox_vm_qemu" "win-11" {
  agent = 1
  bios  = "ovmf"
  boot  = "order=virtio0"
  cpu {
    type    = "host"
    sockets = 1
    cores   = 4
  }
  ciupgrade              = false
  define_connection_info = false
  description            = "Windows 11 VM"
  full_clone             = false
  hotplug                = "network,disk,usb"
  machine                = "pc-q35-9.0"
  balloon                = 0
  memory                 = 12288
  name                   = "win-11"
  qemu_os                = "other"
  scsihw                 = "virtio-scsi-single"
  target_nodes           = ["proxmox"]
  start_at_node_boot     = true
  vmid                   = 101
  automatic_reboot       = true

  disks {
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

  # Proxmox uses ms-cert=2023k; this provider version cannot manage that setting.
  efidisk {
    efitype           = "4m"
    format            = "raw"
    pre_enrolled_keys = true
    storage           = "local-lvm"
  }

  tpm_state {
    storage = "local-lvm"
    version = "v2.0"
  }

  network {
    bridge   = "vmbr0"
    firewall = true
    id       = 0
    macaddr  = "BC:24:11:07:F7:91"
    model    = "virtio"
  }

  startup_shutdown {
    order            = 2
    shutdown_timeout = 0
    startup_delay    = 0
  }

  lifecycle {
    prevent_destroy = true
    # The provider does not refresh the existing TPM into state. Keep its
    # configuration for creation, but leave subsequent TPM changes to Proxmox.
    ignore_changes = [tpm_state]
  }
}
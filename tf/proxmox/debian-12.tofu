resource "proxmox_vm_qemu" "debian-12" {
  # The GPU reset hook (local:snippets/gpu-reset.sh) is configured in Proxmox;
  # telmate/proxmox 3.0.2-rc10 does not expose hookscript.
  agent = 1
  bios  = "seabios"
  boot  = "order=virtio0"
  cpu {
    type    = "host"
    sockets = 1
    cores   = 6
  }
  ciupgrade              = false
  define_connection_info = false
  description            = "Debian 12 VM"
  full_clone             = false
  hotplug                = "network,disk,usb"
  machine                = "q35"
  balloon                = 24576
  memory                 = 32768
  name                   = "debian-12"
  qemu_os                = "l26"
  scsihw                 = "virtio-scsi-single"
  target_nodes           = ["proxmox"]
  start_at_node_boot     = true
  vmid                   = 100

  disks {
    virtio {
      virtio0 {
        passthrough {
          file      = "/dev/disk/by-id/wwn-0x5002538d41e14f59"
          replicate = true
        }
      }
      virtio1 {
        passthrough {
          file      = "/dev/disk/by-id/wwn-0x5001b44dd44ffced"
          replicate = true
        }
      }
    }
  }

  network {
    bridge   = "vmbr0"
    firewall = true
    id       = 0
    macaddr  = "BC:24:11:C1:69:D7"
    model    = "virtio"
  }

  startup_shutdown {
    order            = 1
    shutdown_timeout = 0
    startup_delay    = 0
  }

  pcis {
    pci0 {
      mapping {
        mapping_id  = "gtx-970"
        pcie        = false
        primary_gpu = false
        rombar      = true
      }
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}
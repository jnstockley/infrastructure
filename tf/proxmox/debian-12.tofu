resource "proxmox_vm_qemu" "debian-12-testing" {
  name             = "debian-12-testing"
  target_node      = "proxmox"
  vmid             = 900
  desc             = "Debian 12"
  bios             = "ovmf"
  onboot           = true
  startup          = "order=1"
  vm_state         = "running"
  protection       = true
  boot             = "order=virtio0;sata0"
  agent            = 1
  qemu_os          = "l26"
  memory           = 24576
  sockets          = 1
  cores            = 6
  cpu_type         = "host"
  hotplug          = "network,disk,usb"
  nameserver       = "192.168.0.1"
  automatic_reboot = true

  vga {
    type = "std"
  }

  network {
    id       = 0
    model    = "virtio"
    bridge   = "vmbr0"
    firewall = true
  }

  disks {
    sata {
      sata0 {
        cdrom {
          iso = "local:iso/debian-12.7.0-amd64-netinst.iso"
        }
      }
    }
    virtio {
      virtio0 {
        passthrough {
          asyncio   = "io_uring"
          backup    = true
          cache     = "none"
          discard   = false
          file      = "/dev/disk/by-id/wwn-0x5002538d41e14f59"
          readonly  = false
          replicate = false
          serial    = "S2R5NX0J414815P"
        }
      }
      virtio1 {
        passthrough {
          asyncio   = "io_uring"
          backup    = true
          cache     = "none"
          discard   = false
          file      = "/dev/disk/by-id/wwn-0x5001b448b02ee912"
          readonly  = false
          replicate = false
          serial    = "22291W800281"
        }
      }
    }
  }
}
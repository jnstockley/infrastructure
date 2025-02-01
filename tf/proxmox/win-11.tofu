resource "proxmox_vm_qemu" "win-11" {
  name             = "win-11"
  target_node      = "proxmox"
  vmid             = 100
  desc             = "Windows 11"
  bios             = "ovmf"
  onboot           = true
  startup          = "order=any"
  vm_state         = "running"
  protection       = true
  boot             = "order:virtio1:virtio0"
  agent            = 1
  qemu_os          = "win11"
  memory           = 4096
  sockets          = 1
  cores            = 4
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
    virtio {
      virtio0 {
        cdrom {
          iso         = "local:iso/win11.iso"
          passthrough = false
        }
      }
      virtio1 {
        passthrough {
          async     = "io_uring"
          backup    = true
          cache     = "none"
          discard   = false
          file      = "/dev/disk/by-id/wwn-0x5000c5003ea177e3"
          readonly  = false
          replicate = false
          serial    = "HKQ01XRC"
        }
      }
      virtio2 {
        passthrough {
          async     = "io_uring"
          backup    = true
          cache     = "none"
          discard   = false
          file      = "/dev/disk/by-id/wwn-0x5000c500e6255bfa"
          readonly  = false
          replicate = false
          serial    = "WWZ1YK3J"
        }
      }
      virtio3 {
        passthrough {
          async     = "io_uring"
          backup    = true
          cache     = "none"
          discard   = false
          file      = "/dev/disk/by-id/wwn-0x5000c500e60e4bd8"
          readonly  = false
          replicate = false
          serial    = "WSD9AK0W"
        }
      }
    }
  }

  efidisk {
    efitype           = "4m"
    storage           = "local-lvm"
    pre-enrolled-keys = 1
  }
  efidisk {
    efitype = "4M"
    storage = "local-lvm"
    version = "v2.0"
  }
}
resource "proxmox_vm_qemu" "win-11-testing" {
  name             = "win-11-testing"
  target_node      = "proxmox"
  vmid             = 901
  desc             = "Windows 11"
  bios             = "ovmf"
  onboot           = true
  startup          = "order=2"
  vm_state         = "running"
  protection       = true
  boot             = "order=virtio0;sata0"
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
    sata {
      sata0{
        cdrom {
          iso = "local:iso/Win11_21H2_English_x64.iso"
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
          file      = "/dev/disk/by-id/wwn-0x5000c5003ea177e3"
          readonly  = false
          replicate = false
          serial    = "HKQ01XRC"
        }
      }
      virtio1 {
        passthrough {
          asyncio   = "io_uring"
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
          asyncio   = "io_uring"
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
    efitype = "4m"
    storage = "local-lvm"
  }
  efidisk {
    efitype = "4m"
    storage = "local-lvm"
  }
}
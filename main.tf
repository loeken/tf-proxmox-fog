terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
    }
  }
}
provider "proxmox" {
  pm_api_url = "https://homeserver:8006/api2/json"
  pm_password = "demotime"
  pm_user = "root@pam"
  pm_tls_insecure = "true"
} 

resource "proxmox_vm_qemu" "fog" {
  agent = 1
  count = 1
  name = "fog"
  target_node = "homeserver"
  clone = "template"
  full_clone = true
  os_type = "cloud-init"
  vcpus = 1
  memory = 1024
  scsihw            = "virtio-scsi-pci"
  ipconfig0 = "ip=dhcp"
  disk {
    type            = "virtio"
    storage = "archive1"
    size = "250G"
  }
  lifecycle {
     ignore_changes = [
       network,
       sshkeys,
       disk
     ]
  }
}

terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
      version = "0.6.12"
    }
  }
}
# instance the provider
provider "libvirt" {
  uri = var.qemu_host
}

resource "libvirt_volume" "os" {
  name           = "${lower(var.vm_name)}-os.qcow2"
  pool           = var.qemu_datastore
  size           = var.os_size_gb*1024*1024*1024
}

resource "libvirt_volume" "data" {
  name           = "${lower(var.vm_name)}-data.qcow2"
  pool           = var.qemu_datastore
  size           = var.data_size_gb*1024*1024*1024
}

# Create the machine
resource "libvirt_domain" "talos" {
  name      = var.vm_name
  autostart = var.autostart
  memory    = var.mem_gb*1024
  vcpu      = var.num_cpu

  network_interface {
    bridge = var.net_interface
  }

  # IMPORTANT: this is a known bug on cloud images, since they expect a console
  # we need to pass it
  # https://bugs.launchpad.net/cloud-images/+bug/1573095
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = var.iso
  }

  disk {
    volume_id = libvirt_volume.os.id
  }

  disk {
    volume_id = libvirt_volume.data.id
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}

# IPs: use wait_for_lease true or after creation use terraform refresh and terraform show for the ips of domain

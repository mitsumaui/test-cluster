terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
      version = "0.6.11"
    }
  }
}# We fetch the latest ubuntu release image from their mirrors

# instance the provider
provider "libvirt" {
  uri = "qemu+ssh://jason@192.168.167.7/system" 
}


resource "libvirt_volume" "talos" {
  name   = "talos-amd64.iso"
  pool   = "ISOs"
  source = "https://github.com/talos-systems/talos/releases/download/v0.13.2/talos-amd64.iso"
  format = "iso"
}
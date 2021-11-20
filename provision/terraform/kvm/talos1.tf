# module "talos1" {
#   source    = "./modules/talos-node/"
  
#   qemu_host      = "qemu://jason@192.168.167.7/system" # "qemu:///system"
#   qemu_datastore = "FD-SSD"

#   vm_name   = "talos1"
#   mem_gb    = 6
#   num_cpu   = 4
#   autostart = true
#   iso       = libvirt_volume.talos.id

#   net_interface = "br0"
#   ip_address   = "192.168.167.22"

#   os_size_gb   = 20
#   data_size_gb = 30
# }
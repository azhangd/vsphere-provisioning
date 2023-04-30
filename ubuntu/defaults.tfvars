# vSphere credentials
vsphere_user                        = var.vsphere_user
vsphere_password                    = var.vsphere_password

# Ubuntu admin credentials
admin_user                          = var.admin_user
admin_password                      = var.admin_password

# vSphere settings
vsphere_server                      = "your_vsphere_server"
vsphere_datacenter                  = "your_vsphere_datacenter"
vsphere_datastore_cluster           = "your_vsphere_datastore_cluster"
vsphere_datastore                   = "your_vsphere_datastore"
vsphere_resource_pool               = "your_vsphere_resource_pool"
vsphere_folder                      = "ubuntu"
vsphere_vm_template_name            = "ubuntu-template"

# VM configuration
vsphere_virtual_machine_name        = "vm_name"
vsphere_virtual_machine_count       = 1 
vsphere_virtual_machine_cpu_count   = 2       # Replace with number of CPUs
vsphere_virtual_machine_memory_size = 2048    # Replace with amount of memory in MB
num_cores_per_socket                = 1       # Replace with number of cores per socket
cpu_hot_add_enabled                 = true
cpu_hot_remove_enabled              = true
memory_hot_add_enabled              = true
domain                              = "your_domain"

# Network configuration
network_cards                       = ["production", "development"] # Replace with your networks
ipv4_submask                        = ["24"]  # Replace with your submask
ip_addresses                        = ["192.168.1.10", "10.10.10.10"] # Replace with your IP addresses

dns_servers = {
  # Replace with your DNS servers
  production   = ["192.168.1.2", "192.168.1.3"]
  development  = ["10.10.10.2", "10.10.10.3"]
}

gateways = {
  # Replace with your gateways
  production   = "192.168.1.1"
  development  = "10.10.10.1"
}
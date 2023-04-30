data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore_cluster" "datastore_cluster" {
  count         = var.vsphere_datastore_cluster != "" ? 1 : 0
  name          = var.vsphere_datastore_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  count         = var.vsphere_datastore != "" && var.vsphere_datastore_cluster == "" ? 1 : 0
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.vsphere_resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  for_each      = toset(var.network_cards)
  name          = each.value
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vsphere_vm_template_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  count                  = var.vsphere_virtual_machine_count
  name                   = var.vsphere_virtual_machine_name
  resource_pool_id       = data.vsphere_resource_pool.pool.id
  folder                 = var.vsphere_folder
  datastore_cluster_id   = var.vsphere_datastore_cluster != "" ? data.vsphere_datastore_cluster.datastore_cluster[0].id : null
  datastore_id           = var.vsphere_datastore != "" ? data.vsphere_datastore.datastore[0].id : null
  num_cpus               = var.vsphere_virtual_machine_cpu_count
  num_cores_per_socket   = var.num_cores_per_socket
  cpu_hot_add_enabled    = var.cpu_hot_add_enabled
  cpu_hot_remove_enabled = var.cpu_hot_remove_enabled
  memory                 = var.vsphere_virtual_machine_memory_size
  memory_hot_add_enabled = var.memory_hot_add_enabled
  guest_id               = data.vsphere_virtual_machine.template.guest_id
  scsi_type              = data.vsphere_virtual_machine.template.scsi_type

  dynamic "network_interface" {
    for_each = data.vsphere_network.network
    content {
      network_id   = data.vsphere_network.network[network_interface.key].id
      adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
    }
  }

  dynamic "disk" {
    for_each = var.disk_sizes
    iterator = disks
    content {
      label            = "disk${disks.key}"
      size             = var.disk_sizes[disks.key]
      unit_number      = disks.key
      thin_provisioned = data.vsphere_virtual_machine.template.disks[disks.key].thin_provisioned
      eagerly_scrub    = data.vsphere_virtual_machine.template.disks[disks.key].eagerly_scrub
    }
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = var.vsphere_virtual_machine_name
        domain    = var.domain
      }

      dynamic "network_interface" {
        for_each = data.vsphere_network.network
        content {
          ipv4_address = var.ip_addresses[count.index % length(var.ip_addresses)]
          ipv4_netmask = "%{if length(var.ipv4_submask) == 1}${var.ipv4_submask[0]}%{else}${var.ipv4_submask[network_interface.key]}%{endif}"
        }
      }

      dns_server_list = var.dns_servers[var.network_cards[0]]
      ipv4_gateway    = var.gateways[var.network_cards[0]]
    }
  }
}
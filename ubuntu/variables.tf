# Description: This file contains the variables used by the Terraform configuration.

# vSphere credentials

variable "vsphere_user" {
  description = "The vSphere user with necessary permissions to create resources."
}

variable "vsphere_password" {
  description = "The password for the vSphere user."
}

# Ubuntu admin credentials

variable "admin_user" {
  description = "The username for the virtual machine's OS."
}

variable "admin_password" {
  description = "The password for the virtual machine's OS user."
}

# vSphere settings

variable "vsphere_server" {
  description = "The vCenter server hostname or IP address."
}

variable "vsphere_datacenter" {
  description = "The name of the vSphere Datacenter where resources will be created."
}

variable "vsphere_datastore_cluster" {
  description = "Datastore cluster to deploy the VM."
  default     = ""
}

variable "vsphere_datastore" {
  description = "Datastore to deploy the VM."
  default     = ""
}

variable "vsphere_resource_pool" {
  description = "The name of the vSphere Resource Pool where the virtual machine will be deployed."
}

variable "network_cards" {
  description = "The list of networks to attach to the virtual machine."
  type        = list(string)
}

variable "ipv4_submask" {
  description = "ipv4 Subnet Mask"
  type        = list(string)
  default     = ["24"]
}

variable "vsphere_folder" {
  description = "The name of the folder where the virtual machine will be placed."
}

variable "vsphere_vm_template_name" {
  description = "The name of the vSphere VM template used to create the virtual machine."
}

# VM configuration

variable "vsphere_virtual_machine_name" {
  description = "The name of the virtual machine to be created."
}

variable "vsphere_virtual_machine_count" {
  description = "The number of virtual machines to create."
}

variable "vsphere_virtual_machine_cpu_count" {
  description = "The number of virtual CPUs to assign to the virtual machine."
}

variable "vsphere_virtual_machine_memory_size" {
  description = "The amount of memory (in MB) to assign to the virtual machine."
}

variable "num_cores_per_socket" {
  description = "The number of cores to distribute among the CPUs in this virtual machine. If specified, the value supplied to num_cpus must be evenly divisible by this value."
  type        = number
  default     = 1
}

variable "cpu_hot_add_enabled" {
  description = "Allow CPUs to be added to this virtual machine while it is running."
  default     = null
}

variable "cpu_hot_remove_enabled" {
  description = "Allow CPUs to be removed to this virtual machine while it is running."
  default     = null
}

variable "memory_hot_add_enabled" {
  description = "Allow memory to be added to this virtual machine while it is running."
  default     = null
}

variable "domain" {
  description = "The domain name for the virtual machine."
}

variable "disk_sizes" {
  description = "The list of disk sizes (in GB) to be attached to the virtual machine."
  type        = list(number)
  default     = []
}

# Network configuration
variable "ip_addresses" {
  type        = list(string)
  description = "List of IP addresses to be assigned to the virtual machines"
  default     = []
}

variable "gateways" {
  description = "The gateways for each network"
  type = map(string)
}

variable "dns_servers" {
  description = "The DNS servers for each network."
  type = map(list(string))
}
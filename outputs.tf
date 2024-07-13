# Resource Group ID
output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

# Output Public IPs of all VMs
output "vm_public_ips" {
  value = { for i in range(length(azurerm_public_ip.vm_public_ip)) : "VM-${i + 1}" => azurerm_public_ip.vm_public_ip[i].ip_address }
  description = "The public IP addresses of all virtual machines, mapped by VM identifier."
}

# Output Private IPs of all VMs
output "vm_private_ips" {
  value = { for i in range(length(azurerm_network_interface.nic-1)) : "VM-${i + 1}" => azurerm_network_interface.nic-1[i].ip_configuration[0].private_ip_address }
  description = "The private IP addresses of all virtual machines, mapped by VM identifier."
}
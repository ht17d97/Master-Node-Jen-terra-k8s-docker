output "resource_group_name" {
  value       = resource.azurerm_resource_group.example.name
}
output "resource_group_location" {
  value       = resource.azurerm_resource_group.example.location
}
output "virtualNet_name" {
  value       = resource.azurerm_virtual_network.example.name
}
output "subnet" {
  value       = resource.azurerm_subnet.example.name
}
output "address_space_details" {
  value       = resource.azurerm_virtual_network.example.address_space
}
output "address_prefixes_details" {
  value      = resource.azurerm_subnet.example.address_prefixes
}
output "nic_details" {
  value = [for nic in azurerm_network_interface.example : nic.name]
//  value      = resource.azurerm_network_interface.example[count.index].name
}
output "nsg_rule_details" {
  value      = resource.azurerm_network_security_group.example.name
}
output "vm_details" {
  value      = [for vm in azurerm_linux_virtual_machine.example : vm.name]
//  value      = resource.azurerm_linux_virtual_machine.example[count.index].name
}
output "vm_size_details" {
  value      = [for vm in azurerm_linux_virtual_machine.example : vm.size]
//  value      = resource.azurerm_linux_virtual_machine.example[count.index].size
}
output "public_ip_vm" {
  value      = [for ip in azurerm_public_ip.example : ip.name]
}
output "destination_port_details" {
  value = [for rule in azurerm_network_security_group.example.security_rule : rule.destination_port_ranges]
}
# output "source_port_details" {
#   value      = resource.azurerm_network_security_group.example.security_rule.source_port_range
# }
output "nsg_rule_priority_details" {
  value      = [for rule in azurerm_network_security_group.example.security_rule : rule.priority]
}
output "nsg_rule_name_details" {
  value      = [for rule in azurerm_network_security_group.example.security_rule : rule.name]
}
output "direction_nsg_details" {
  value      = [for rule in azurerm_network_security_group.example.security_rule : rule.direction]
}
output "ngs_rule_define_details" {
  value      = [for rule in azurerm_network_security_group.example.security_rule : rule.access]
}

output "resource_group_name" {
  value = module.rg.resource_group_name
}
output "resource_group_location" {
  value = module.rg.resource_group_location
}
output "virtualNet_name" {
  value = module.rg.virtualNet_name
}
output "subnet" {
  value = module.rg.subnet
}
output "address_space_details" {
  value = module.rg.address_space_details
}
output "address_prefixes_details" {
  value = module.rg.address_prefixes_details
}
output "nic_details" {
  value = module.rg.nic_details
}
output "nsg_rule_details" {
  value = module.rg.nsg_rule_details
}
output "vm_details" {
  value = module.rg.vm_details
}
output "vm_size_details" {
  value = module.rg.vm_size_details
}
output "public_ip_vm" {
  value = module.rg.public_ip_vm
}
output "destination_port_details" {
  value = module.rg.destination_port_details
}
# output "source_port_details" {
#   value = module.rg.source_port_details
# }
output "nsg_rule_priority_details" {
  value = module.rg.nsg_rule_priority_details
}
output "nsg_rule_name_details" {
  value = module.rg.nsg_rule_name_details
}
output "direction_nsg_details" {
  value = module.rg.direction_nsg_details
}
output "ngs_rule_define_details" {
  value = module.rg.ngs_rule_define_details
}

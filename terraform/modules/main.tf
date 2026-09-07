module "rg" {
  source            = "./module_rg"
  rg_name           = var.rg_name
  rg_location       = var.rg_location
  vnet_name         = var.vnet_name
  subnet_range      = var.subnet_range
  subnet_name       = var.subnet_name
  address_pre       = var.address_pre
  nic               = var.nic
  nsg_name          = var.nsg_name
  vm_name           = var.vm_name
  vm_size           = var.vm_size
  vmcountnumber     = var.vmcountnumber
  public_ip_vm      = var.public_ip_vm
  nsg_rule_name     = var.nsg_rule_name
  nsg_rule_priority = var.nsg_rule_priority
  # source_ports      = var.source_ports
  destination_ports  = var.destination_ports
  direction_nsg     = var.direction_nsg
  ngs_rule_define   = var.ngs_rule_define
}

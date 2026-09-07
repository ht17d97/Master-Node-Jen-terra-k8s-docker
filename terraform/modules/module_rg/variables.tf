variable "rg_name" {
  type        = string
}
variable "rg_location" {
  type        = string
}
variable "vnet_name" {
  type        = string
}
variable "subnet_range" {
  type        = list(any)
}
variable "subnet_name" {
  type        = string
}
variable "address_pre" {
  type        = list(any)
}
variable "nic" {
  type        = string
}
variable "nsg_name" {
  type        = string
}
variable "vm_name" {
  type        = string
}
variable "vm_size" {
  type        = string
}
variable "vmcountnumber" {
  type        = number
}
variable "public_ip_vm" {
  type        = string
}
variable "nsg_rule_priority" {
  type        = number
}
variable "destination_ports" {
  type        = list(any)
}
# variable "source_ports" {
#   type        = list(any)
# }
variable "nsg_rule_name" {
  type        = string
}
variable "direction_nsg" {
  type        = string
}
variable "ngs_rule_define" {
  type        = string
}
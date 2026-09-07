resource "azurerm_resource_group" "example" {
  name     = var.rg_name
  location = var.rg_location
}

resource "azurerm_virtual_network" "example" {
  name                = var.vnet_name
  address_space       = var.subnet_range
  location            = var.rg_location
  resource_group_name = var.rg_name

  depends_on = [azurerm_resource_group.example]
}

resource "azurerm_subnet" "example" {
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.address_pre

  depends_on = [azurerm_virtual_network.example]
}

resource "azurerm_network_interface" "example" {
  name                = "${var.nic}-${count.index + 1}"
  location            = var.rg_location
  resource_group_name = var.rg_name
  count               = var.vmcountnumber

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_security_group" "example" {
  name                = var.nsg_name
  location            = var.rg_location
  resource_group_name = var.rg_name

  security_rule {
    name                       = var.nsg_rule_name
    priority                   = var.nsg_rule_priority
    direction                  = var.direction_nsg
    access                     = var.ngs_rule_define
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = var.destination_ports
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  depends_on = [azurerm_resource_group.example]
}

resource "azurerm_public_ip" "example" {
  name                = "${var.public_ip_vm}-${count.index + 1}"
  resource_group_name = var.rg_name
  location            = var.rg_location
  allocation_method   = "Static"
  count               = var.vmcountnumber

  depends_on = [azurerm_resource_group.example]
}

resource "azurerm_linux_virtual_machine" "example" {
  name                            = "${var.vm_name}-${count.index + 1}"
  resource_group_name             = var.rg_name
  location                        = var.rg_location
  size                            = var.vm_size
  computer_name                   = "TESTVM-${count.index + 1}"
  admin_username                  = "adminuser"
  admin_password                  = var.admin_password
  disable_password_authentication = false
  count                          = var.vmcountnumber
  network_interface_ids = [
    azurerm_network_interface.example[count.index].id,
  ]
  os_disk {
    name                 = "OSdisk-${count.index + 1}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "9-lvm"
    version   = "9.5.2024112215"
  }
}


resource "azurerm_resource_group" "example" {
  name     = "Terraform-RG"
  location = "South India"
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "example" {
  name                = "acceptanceTestPublicIp1-${count.index + 1}"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"
  count               = var.vmcountnumber
}

resource "azurerm_network_interface" "example" {
  name                = "example-nic-${count.index + 1}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  count               = var.vmcountnumber

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_security_group" "example" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "test123"
    priority                   = 4045
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["22", "80", "443", "8080", "8081", "8082"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


resource "azurerm_linux_virtual_machine" "example" {
  name                            = "example-machine-${count.index + 1}"
  resource_group_name             = azurerm_resource_group.example.name
  location                        = azurerm_resource_group.example.location
  size                            = "Standard_F2"
  computer_name                   = "hostname-${count.index + 1}"
  admin_username                  = "adminuser"
  admin_password                  = var.admin_password
  count                           = var.vmcountnumber
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.example[count.index].id,
  ]
  os_disk {
    name              = "osdisk-${count.index + 1}"
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

# resource "azurerm_managed_disk" "example" {
#   name                 = "data-disk-1"
#   location             = azurerm_resource_group.example.location
#   resource_group_name  = azurerm_resource_group.example.name
#   storage_account_type = "Standard_LRS"
#   create_option        = "Empty"
#   disk_size_gb         = "10"
#   count                = var.vmcountnumber
# }
# resource "azurerm_virtual_machine_data_disk_attachment" "example" {
#   managed_disk_id    = azurerm_managed_disk.example.id
#   virtual_machine_id = azurerm_linux_virtual_machine.example.id
#   lun                = "01"
#   caching            = "ReadWrite"
# }
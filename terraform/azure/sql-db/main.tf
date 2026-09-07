resource "azurerm_resource_group" "example" {
  name     = "Terraform-rg"
  location = "East Asia"
}

resource "azurerm_mssql_server" "example" {
  name                         = "tf-mysql-server1"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = "azreadmin"
  administrator_login_password = "azurerm_key_vault_secret.example1.value"
  minimum_tls_version          = "1.2"

  depends_on = [azurerm_resource_group.example]
}

resource "azurerm_mssql_database" "example" {
  name         = "prod-db"
  server_id    = azurerm_mssql_server.example.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"

  depends_on   = [azurerm_mssql_server.example,azurerm_mssql_database.example]
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "example" {
  name                        = "prod-keyvault-new"
  location                    = azurerm_resource_group.example.location
  resource_group_name         = azurerm_resource_group.example.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get", "List", "Set",
    ]
  }
}

resource "azurerm_key_vault_secret" "example1" {
  name         = "prod-db-password"
  value        = "T0rn@d0"
  key_vault_id = azurerm_key_vault.example.id
}

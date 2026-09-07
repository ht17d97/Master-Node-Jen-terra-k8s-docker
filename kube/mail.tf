resource "azurerm_resource_group" "example" {
  name     = "NurunRG"
  location = "West Europe"
}
resource "azurerm_app_service_plan" "example" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Linux"
}

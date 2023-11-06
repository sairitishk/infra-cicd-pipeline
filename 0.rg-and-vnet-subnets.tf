resource "azurerm_resource_group" "tftest" {
  name     = var.rg_name
  location = var.rg_location
}

resource "azurerm_virtual_network" "vnet1" {
  resource_group_name = var.rg_name
  name                = "${var.rg_name}-vnet1"
  location            = var.rg_location
  address_space       = var.vnet_cidr

}

resource "azurerm_subnet" "subnet1" {
  count                = length(var.subnet_address_prefixes)
  resource_group_name  = var.rg_name
  name                 = "${var.rg_name}-subnet-${count.index + 1}"
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = [element(var.subnet_address_prefixes, count.index)]
}

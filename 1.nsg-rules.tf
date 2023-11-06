resource "azurerm_network_security_group" "nsg1" {
  resource_group_name = var.rg_name
  name                = "${var.rg_name}-nsg-1"
  location            = var.rg_location

}


resource "azurerm_network_security_rule" "example" {
  name                        = "Allow-All"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.nsg1.name
}
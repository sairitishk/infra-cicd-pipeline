resource "azurerm_storage_account" "testdepon" {
  resource_group_name      = var.rg_name
  name                     = "testdeponsa"
  location                 = azurerm_resource_group.tftest.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    Env   = var.env
    Batch = var.batch
  }

}

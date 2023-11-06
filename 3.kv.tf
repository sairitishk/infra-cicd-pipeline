data "azurerm_client_config" "current" {}

data "azurerm_key_vault" "certskv" {
  resource_group_name = "Common-RG"
  name                = "certsnew"
}

resource "azurerm_key_vault_access_policy" "name" {
  key_vault_id = data.azurerm_key_vault.certskv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id
  secret_permissions = [
  "Get", "List", "Purge", "Recover", "Restore", "Set", "Delete", "Recover"]
}

resource "azurerm_key_vault_secret" "random-pass" {
  count        = 3
  name         = "random-pass-${count.index + 1}"
  value        = element(random_password.pass1.*.result, count.index)
  key_vault_id = data.azurerm_key_vault.certskv.id

}

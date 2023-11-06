resource "azurerm_public_ip" "vnet1-pip" {
  count               = var.vm_count
  resource_group_name = var.rg_name
  location            = var.rg_location
  name                = "${azurerm_virtual_network.vnet1.name}-pip-${count.index + 1}"
  allocation_method   = "Dynamic"
  depends_on          = [azurerm_storage_account.testdepon]
  tags = {
    Env   = var.env
    Batch = var.batch
  }
}

resource "azurerm_network_interface" "vm-nics" {
  count               = var.vm_count
  resource_group_name = var.rg_name
  location            = var.rg_location
  name                = "vms-nic-${count.index + 1}"
  ip_configuration {
    name                          = "vms-ipconfig-${count.index + 1}"
    subnet_id                     = element(azurerm_subnet.subnet1.*.id, count.index)
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.vnet1-pip.*.id, count.index)
  }
  tags = {
    Env   = var.env
    Batch = var.batch
  }

}

resource "azurerm_linux_virtual_machine" "vms" {
  count               = var.vm_count
  resource_group_name = var.rg_name
  location            = var.rg_location
  name                = "${var.rg_name}-vm-${count.index + 1}"
  size                = var.vm_size
  admin_username      = var.admin_username
  # admin_password = "Ritish@123456"
  admin_password                  = element(random_password.pass1.*.result, count.index)
  disable_password_authentication = false
  network_interface_ids = [
    element(azurerm_network_interface.vm-nics.*.id, count.index)
  ]
  os_disk {
    name                 = "vm-${count.index + 1}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = "30"
  }
  identity {
    type = "SystemAssigned"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal-daily"
    sku       = "20_04-daily-lts-gen2"
    version   = "latest"
  }
  tags = {
    Env   = var.env
    Batch = var.batch
  }

}
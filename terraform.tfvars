rg_name                 = "TF-First-RG"
rg_location             = "eastus"
vnet_cidr               = ["10.33.0.0/16"]
subnet_address_prefixes = ["10.33.1.0/24", "10.33.2.0/24", "10.33.3.0/24"]
vm_count                = 3
env                     = "Dev"
batch                   = "test1"
vm_size                 = "Standard_B1s"
admin_username          = "adminritish"

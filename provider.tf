terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id   = var.subscription_id
  tenant_id         = var.tenant_id
  client_id         = var.client_id
  client_secret     = var.client_secret
}

terraform {
  backend "azurerm" {
    resource_group_name  = "Common-RG"
    storage_account_name = "tfazurebackup"
    container_name       = "tfbacknew"
    key                  = "terraform.tfstate"
  }
}
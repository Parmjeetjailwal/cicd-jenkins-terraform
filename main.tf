# Terraform version with required provider
terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "demo"
    storage_account_name = "giitsollutionbackend"
    container_name       = "tfstatefiles"
    key                  = "dev/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  features {}
  alias = "iac"
  subscription_id   = "3f108ccd-5649-48da-93f5-0d97fd694afe"
  tenant_id         = "c494f109-4010-4781-b95f-4489dbaaa438"
  client_id         = "8ddd7c4b-84e2-4ea8-a11d-8dbb36801356"
  client_secret     = data.azurerm_key_vault_secret.iac.value
}

data "azurerm_key_vault" "jenkins-iac" {
  name = "keys-for-jenkins-iac"
  resource_group_name = "keys"
}

data "azurerm_key_vault_secret" "iac" {
  name         = "iac-sec"
  key_vault_id = data.azurerm_key_vault.jenkins-iac.id
}

resource "azurerm_resource_group" "rg" {
  provider = azurerm.iac
  name     = "demo2"
  location = "Central India"
}


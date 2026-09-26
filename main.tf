terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Standard tags applied to every resource — see docs/tagging-strategy.md
locals {
  common_tags = {
    Environment = "Production"
    Owner       = "Mike Zapata"
    Project     = "Azure Secure Enterprise Platform"
    ManagedBy   = "Terraform"
    CostCenter  = "IT"
  }
}

resource "azurerm_resource_group" "hub" {
  name     = "gtg-hub-prod"
  location = "East US"
  tags     = local.common_tags
}

resource "azurerm_resource_group" "spoke" {
  name     = "gtg-spoke-prod"
  location = "East US"
  tags     = local.common_tags
}

resource "azurerm_resource_group" "security" {
  name     = "gtg-security-prod"
  location = "East US"
  tags     = local.common_tags
}

resource "azurerm_resource_group" "monitoring" {
  name     = "gtg-monitoring-prod"
  location = "East US"
  tags     = local.common_tags
}
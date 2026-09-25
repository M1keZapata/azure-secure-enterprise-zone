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

resource "azurerm_resource_group" "hub" {
  name     = "gtg-hub-prod"
  location = "East US"
  tags = { "environment" = "production"
  }
}

resource "azurerm_resource_group" "spoke" {
  name     = "gtg-spoke-prod"
  location = "East US"
  tags = { "environment" = "production"
  }
}

resource "azurerm_resource_group" "security" {
  name     = "gtg-security-prod"
  location = "East US"
  tags = { "environment" = "production"
  }
}

resource "azurerm_resource_group" "monitoring" {
  name     = "gtg-monitoring-prod"
  location = "East US"
  tags = { "environment" = "production"
  }
}
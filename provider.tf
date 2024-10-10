terraform {               //for log in ssh azureuser@publicip
  required_providers {    //exit for log out
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.100.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  skip_provider_registration = true
  
  features {}
  //subscription_id = ""
  
}

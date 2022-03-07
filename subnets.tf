##########################################################################################
#
# subnets.tf
#
# This file contains additional subnets besides those required for Site-to-Site VPN
#
##########################################################################################


# This file contains additional subnets 
# besides those required for Site-to-Site VPN
resource "azurerm_subnet" "subnet_main" {
  name                 = var.subnet_main_name
  resource_group_name  = azurerm_resource_group.rg_main.name
  virtual_network_name = azurerm_virtual_network.vnet_main.name
  address_prefixes     = var.subnet_main_cidr_ranges
}


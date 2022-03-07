##########################################################################################
# 
# dns.tf
# 
# Creates a private dns zone and links it to the VNET.
# 
##########################################################################################
resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = var.private_dns_zone_name
  resource_group_name = azurerm_resource_group.rg_main.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_link_vnet_main" {
  name                  = var.default_resource_name
  resource_group_name   = azurerm_resource_group.rg_main.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet_main.id
  registration_enabled  = "true"
}


##########################################################################################
# 
# main.tf
# 
# This file contains the bare minimum of resources needed for a VPN enclave.
# 
# A bare minimum is not so useful, so this goes along with several other Terraform file.
# 
# dns.tf - Adds DNS
# dns_forwarder.tf - Adds a DNS Forwarder VM
# natgw.tf - Adds a NATGW (Useful for internet access NOT through the VPN)
# subnets.tf - Additional Subnets that can be used for VMs, OpenShift, et cetera
# 
##########################################################################################

resource "azurerm_resource_group" "rg_main" {
  name     = var.resource_group_name
  location = var.azure_region_name
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet_main" {
  name                = var.default_resource_name
  resource_group_name = azurerm_resource_group.rg_main.name
  location            = azurerm_resource_group.rg_main.location
  address_space       = var.vnet_address_space

  # DNS Servers are manually set to our DNS Forwarder
  # If you don't want to use the DNS forwarder and have split cloud/on-premise
  # DNS, then omit the following line
  dns_servers         = var.vnet_dns_servers
}

resource "azurerm_subnet" "subnet-gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.rg_main.name
  virtual_network_name = azurerm_virtual_network.vnet_main.name
  address_prefixes     = var.gateway_subnet

}

resource "azurerm_local_network_gateway" "lng_onpremise" {
  name                = var.local_network_gateway_name
  resource_group_name = azurerm_resource_group.rg_main.name
  location            = azurerm_resource_group.rg_main.location
  gateway_address     = var.on_premise_public_ip_address
  address_space       = var.on_premise_private_network_ranges
}


resource "azurerm_public_ip" "public_ip_vpn" {
  name                = var.vpn_azure_public_ip_name
  location            = azurerm_resource_group.rg_main.location
  resource_group_name = azurerm_resource_group.rg_main.name

  allocation_method = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "vnetgw_main" {
  name                = var.on_premise_name
  location            = azurerm_resource_group.rg_main.location
  resource_group_name = azurerm_resource_group.rg_main.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "Basic"

  ip_configuration {
    public_ip_address_id          = azurerm_public_ip.public_ip_vpn.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet-gateway.id
  }
}

resource "azurerm_virtual_network_gateway_connection" "vpn_conn_onpremise" {
  name                = var.on_premise_name
  location            = azurerm_resource_group.rg_main.location
  resource_group_name = azurerm_resource_group.rg_main.name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vnetgw_main.id
  local_network_gateway_id   = azurerm_local_network_gateway.lng_onpremise.id

  shared_key = var.vpn_shared_key
}

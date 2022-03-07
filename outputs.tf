output "vnet_main_address_space" { 
   value = azurerm_virtual_network.vnet_main.address_space[0]
}

output "azure_vpn_public_ip" { 
   value = azurerm_public_ip.public_ip_vpn.ip_address
}

output "vpn_shared_key" { 
   value = azurerm_virtual_network_gateway_connection.vpn_conn_onpremise.shared_key
   sensitive = true
}

output "dns_forwarder_ip" {
   value = azurerm_linux_virtual_machine.vm_dnsforwarder.private_ip_address
}

output "private_dns_zone_name" {
   value = var.private_dns_zone_name
}

output "on_premise_private_network_range" {
   value = var.on_premise_private_network_ranges[0]
}

output "on_premise_public_ip_address" {
   value = var.on_premise_public_ip_address
}

output "on_premise_dns_zones" {
   value = var.on_premise_dns_zones
}

output "on_premise_dns_server" {
   value = var.on_premise_dns_server
}

output "azure_private_dns_server" {
   value = var.azure_private_dns_server
}

output "vnet_dns_reverse_zones" {
   value = var.vnet_dns_reverse_zones
}


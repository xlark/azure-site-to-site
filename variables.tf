variable "azure_region_name" {
	type = string
	description = "Desired Azure Region"
}

variable "resource_group_name" {
	type = string
	description = "Resource Group Name"
}

variable "default_resource_name" {
	type = string
	description = "Default Name for Any resource.  Used if only one of a resource type exists"
}

variable "vnet_address_space" {
	type = list(string)
	description = "List of VNET Address Ranges"
}

variable "vnet_dns_servers" {
	type = list(string)
	description = "List of VNET DNS Servers"
}

variable "dns_forwarder_ip_address" {
	 type = string
	 description = "IP Address of DNS Forwarder VM"
}

variable "gateway_subnet" {
	type = list(string)
	description = "Special subnet for Azure Gateway"
}

variable "vpn_shared_key" {
	type = string
	description = "VPN Shared Key"
	sensitive = true
}

variable "local_network_gateway_name" {
	type = string
	description = "Name for Local Network Gateway"
}

variable "on_premise_private_network_ranges" {
	type = list(string)
	description = "Represents on-premise network IP Ranges, used by the Local Network Gateway."
}

variable "vpn_azure_public_ip_name" {
	type = string
	description = "Name for Public IP Address used by VPN Connection"
}

variable "on_premise_public_ip_address" {
	type = string
	description = "The Public IP address for on-premise site.  Used as the endpoint for the VPN tunnel."
}

variable "on_premise_name" {
	type = string
	description = "On premise name used to name several resources"
}

variable "on_premise_dns_zones" {
	type = list(string)
	description = "On Premise DNS zones"
}

variable "on_premise_dns_server" {
	type = string
	description = "On Premise DNS server"
}

variable "azure_private_dns_server" { 
	type = string
	description = "Azure Private DNS Server"
}

variable "private_dns_zone_name" {
	type = string
	description = "Private DNS zone for VNET"
}

variable "ssh_key_path" {
	type = string
	description = "Path to public SSH Key for DNS Forwarder VM"
	default = "~/.ssh/id_rsa.pub"
}

variable "subnet_main_name" {
	type = string
	description = "Resource name for Main subnet"
}

variable "subnet_main_cidr_ranges" {
	type = list(string)
	description = "List of CIDR ranges for main subnet"
}

variable "vnet_dns_reverse_zones" {
	type = list(string)
	description = "List of DNS Reverse Zones for main VNET"
}



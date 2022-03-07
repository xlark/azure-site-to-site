##########################################################################################
#
# dns_forwarder.tf
#
# Creates  VM that will act as our DNS forwarder
#
##########################################################################################

resource "azurerm_network_interface" "nic_dnsforwarder" {
  name                = "dnsforwarder-nic"
  location            = azurerm_resource_group.rg_main.location
  resource_group_name = azurerm_resource_group.rg_main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet_main.id
    private_ip_address_allocation = "Static"
    private_ip_address		  = var.dns_forwarder_ip_address
  }
}

resource "azurerm_linux_virtual_machine" "vm_dnsforwarder" {
  name                = "dnsforwarder"
  resource_group_name = azurerm_resource_group.rg_main.name
  location            = azurerm_resource_group.rg_main.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic_dnsforwarder.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file(var.ssh_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "82gen2"
    version   = "latest"
  }
}

resource "azurerm_network_security_group" "nsg_dnsforwarder_dns" {
  name                = "dnsforwarder_dns"
  location            = azurerm_resource_group.rg_main.location
  resource_group_name = azurerm_resource_group.rg_main.name

  security_rule {
    name                       = "SSH"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


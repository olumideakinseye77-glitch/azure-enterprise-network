resource "azurerm_network_interface" "hub_nva" {
  name                = "nic-hub-nva"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_forwarding_enabled = true

  ip_configuration {
    name                          = "ipconfig-hub-nva"
    subnet_id                     = azurerm_subnet.hub_shared.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.10.1.4"
  }
}

resource "azurerm_linux_virtual_machine" "hub_nva" {
  name                = "vm-hub-nva"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = "Standard_D2nls_v6"
  admin_username      = "azureuser"

  network_interface_ids = [azurerm_network_interface.hub_nva.id]

  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  custom_data = base64encode(<<-EOF
    #cloud-config
    write_files:
      - path: /etc/sysctl.d/99-ip-forward.conf
        permissions: "0644"
        content: |
          net.ipv4.ip_forward=1
    runcmd:
      - sysctl --system
      - iptables -P FORWARD ACCEPT
  EOF
  )

  tags = {
    Environment = var.environment
    Project     = var.project_name
    Role        = "Hub-NVA"
    ManagedBy   = "Terraform"
  }
}
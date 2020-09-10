# network interface
resource "azurerm_network_interface" "nic-threatp-vm" {
    name                        = "nic-${var.environment}-${var.threatpipes_hostname}"
    location                    = azurerm_resource_group.project_rg.location
    resource_group_name         = azurerm_resource_group.project_rg.name
    tags                        = local.tags

    ip_configuration {
        name                            = "ipconfig-nic-${var.environment}-${var.threatpipes_hostname}-00"
        subnet_id                       = azurerm_subnet.subnet.id
        private_ip_address_allocation   = "Dynamic"
    }
}
# virtual machine
resource "azurerm_linux_virtual_machine" "vm-threatp-linux" {
    name                = "vm-${var.environment}-${var.threatpipes_hostname}-00"
    location            = azurerm_resource_group.project_rg.location
    resource_group_name = azurerm_resource_group.project_rg.name
    tags                = local.tags
    size                = var.threatpipes_size
    admin_username      = var.threatpipes_admin_user
    computer_name       = var.threatpipes_hostname
    network_interface_ids = [
        azurerm_network_interface.nic-threatp-vm.id,
    ]
    # this block prevents that if any sysadmin - ssh key was changed, the VM is replaces
    # if further id.pub keys are needed after the firsttime the machine was deployed, the they need to be added in the OS directly
    lifecycle {
        ignore_changes  = [admin_ssh_keys]
    }
    # OS
    os_disk {
      name                  = "vm-${var.environment}-${var.threatpipes_hostname}-OS"
      caching               = "ReadOnly"
      storage_account_type  = "Standard_LRS"
      disk_size_gb          = var.threatpipes_disk_size_gb
    }
    # image
    dynamic "source_image_reference" {
        for_each            = var.source_image_reference
            content {
                publisher   = source_image_reference.value["publisher"]
                offer       = source_image_reference.value["offer"]
                sku         = source_image_reference.value["sku"]
                version     = source_image_reference.value["version"]
            }
    }
    # ssh keys
    dynamic "admin_ssh_key" {
        for_each            = var.ssh_keys
            content {
                username            = var.threatpipes_admin_user
                public_key          = file("${path.cwd}/../../${admin_ssh_key.value["public_key"]}")
            }
    }
}

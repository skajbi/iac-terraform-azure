resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.main.name
  account_replication_type = var.account_replication_type
  account_tier             = var.account_tier
  location                 = azurerm_resource_group.main.location
}

resource "azurerm_storage_container" "main" {
  name                 = var.storage_container_name
  storage_account_name = azurerm_storage_account.main.name
}

resource "azurerm_storage_blob" "main" {
  name                   = var.storage_blob_name
  storage_account_name   = azurerm_storage_account.main.name
  storage_container_name = azurerm_storage_container.main.name
  type                   = var.storage_blob_type
}

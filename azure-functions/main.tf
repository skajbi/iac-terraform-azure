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

resource "azurerm_app_service_plan" "main" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  sku {
    tier = var.sku_tier
    size = var.sku_size
  }
}

resource "azurerm_function_app" "main" {
  name                       = var.linux_function_app_name
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  app_service_plan_id        = azurerm_app_service_plan.main.id
  storage_account_name       = azurerm_storage_account.main.name
  storage_account_access_key = azurerm_storage_account.main.primary_access_key

}

resource "azurerm_function_app_function" "main" {
  name            = var.function_app_function_name
  config_json     = var.app_function_json_config
  function_app_id = azurerm_function_app.main.id
}

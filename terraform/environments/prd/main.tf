data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "container_env" {
  name     = var.resource_group_names["container_env"]
  location = var.location
}

resource "azurerm_resource_group" "keyvault" {
  name     = var.resource_group_names["keyvault"]
  location = var.location
}

resource "azurerm_resource_group" "openai" {
  name     = var.resource_group_names["openai"]
  location = var.location
}

resource "azurerm_resource_group" "email_communication" {
  name     = var.resource_group_names["email_communication"]
  location = var.location
}

resource "azurerm_resource_group" "communication" {
  name     = var.resource_group_names["communication"]
  location = var.location
}

resource "azurerm_resource_group" "database" {
  name     = var.resource_group_names["database"]
  location = var.location
}

resource "azurerm_resource_group" "storage" {
  name     = var.resource_group_names["storage"]
  location = var.location
}

module "containerapps" {
  source              = "../../modules/containerapps"
  resource_group_name = azurerm_resource_group.container_env.name
  location            = var.location
  env_name            = var.container_apps_config.env_name
  apps                = var.container_apps_config.apps
}

module "keyvault" {
  source              = "../../modules/keyvault"
  resource_group_name = azurerm_resource_group.keyvault.name
  location            = var.location
  kv_name             = var.keyvault_config.kv_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
}

module "openai" {
  source              = "../../modules/openai"
  resource_group_name = azurerm_resource_group.openai.name
  location            = var.location
  name                = var.openai_config.name
}

module "ecs" {
  source              = "../../modules/ecs"
  resource_group_name = azurerm_resource_group.email_communication.name
  location            = var.location
  services            = var.ecs_config.services
}

module "communication" {
  source              = "../../modules/communication"
  resource_group_name = azurerm_resource_group.communication.name
  location            = var.location
  services            = var.communication_config.services
}

module "database" {
  source              = "../../modules/database"
  resource_group_name = azurerm_resource_group.database.name
  location            = var.location
  db_name             = var.database_config.db_name
}

module "storage" {
  source               = "../../modules/storage"
  resource_group_name  = azurerm_resource_group.storage.name
  location             = var.location
  storage_account_name = var.storage_config.storage_account_name
}

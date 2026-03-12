variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
}
variable "resource_group_names" {
  description = "Names for resource groups"
  type        = map(string)
  default = {
    container_env          = "rg-cae-aios-prd-eastus"
    keyvault               = "rg-kv-aios-prd-eastus"
    openai                 = "rg-openai-aios-prd-eastus"
    email_communication    = "rg-ecs-aios-prd-eastus"
    communication          = "rg-comms-aios-prd-eastus"
    database               = "rg-psql-aios-prd-eastus"
    storage                = "rg-st-aios-prd-eastus"
  }
}

variable "container_apps_config" {
  description = "Container Apps configuration"
  type = object({
    env_name = string
    apps     = map(string)
  })
}

variable "keyvault_config" {
  description = "Key Vault configuration"
  type = object({
    kv_name = string
  })
}

variable "openai_config" {
  description = "OpenAI configuration"
  type = object({
    name = string
  })
}

variable "ecs_config" {
  description = "ECS configuration"
  type = object({
    services = map(string)
  })
}

variable "communication_config" {
  description = "Communication configuration"
  type = object({
    services = map(string)
  })
}

variable "database_config" {
  description = "Database configuration"
  type = object({
    db_name = string
  })
}

variable "storage_config" {
  description = "Storage configuration"
  type = object({
    storage_account_name = string
  })
}
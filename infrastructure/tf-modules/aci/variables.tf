variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location for all resources."
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random value so name is unique in your Azure subscription."
}

variable "container_group_name_prefix" {
  type        = string
  description = "Prefix of the container group name that's combined with a random value so name is unique in your Azure subscription."
  default     = "acigroup"
}

variable "container_name_prefix" {
  type        = string
  description = "Prefix of the container name that's combined with a random value so name is unique in your Azure subscription."
  default     = "aci"
}

variable "image" {
  type        = string
  description = "Container image to deploy. Should be of the form repoName/imagename:tag for images stored in public Docker Hub, or a fully qualified URI for other registries. Images from private registries require additional registry credentials."
  default     = "mcr.microsoft.com/azuredocs/aci-helloworld"
}

variable "port" {
  type        = number
  description = "Port to open on the container and the public IP address."
  default     = 80
}

variable "cpu_cores" {
  type        = number
  description = "The number of CPU cores to allocate to the container."
  default     = 1
}

variable "memory_in_gb" {
  type        = number
  description = "The amount of memory to allocate to the container in gigabytes."
  default     = 2
}

variable "restart_policy" {
  type        = string
  description = "The behavior of Azure runtime if container has stopped."
  default     = "OnFailure"
  validation {
    condition     = contains(["Always", "Never", "OnFailure"], var.restart_policy)
    error_message = "The restart_policy must be one of the following: Always, Never, OnFailure."
  }
}

variable "acr_username" {
  type = string
}

variable "acr_password" {
  type = string
}

variable "acr_servername" {
  type = string
}

variable "location" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "private_subnet_id_ag" {
  type = string
}

variable "email_receiver_address" {
  type = string
}

variable "email_receiver_name" {
  type = string
}

variable "whisper_monitor_actiongroup_short_name" {
  type = string
}

variable "whisper_monitor_actiongroup_name" {
  type = string
}

variable "whisper_monitor_alert_name" {
  type = string
}

variable "app_gateway_rg_name" {
  type = string
}

variable "app_gateway_public_ip_name" {
  type = string
}

variable "app_gateway_name" {
  type = string
}

variable "app_gateway_ip_config_name" {
  type = string
}

variable "app_gateway_frontend_port_name" {
  type = string
}

variable "app_gateway_frontend_ip_config_name" {
  type = string
}

variable "container_ipv4_address" {
  type = string
}


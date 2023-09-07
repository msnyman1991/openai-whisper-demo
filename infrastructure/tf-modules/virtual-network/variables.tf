variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "virtual_network_cidr" {
  type = list(string)
}

variable "private_subnet_name" {
  type = string
}

variable "private_address_prefixes" {
  type = list(string)
}

variable "private_address_prefixes_ag" {
  type = list(string)
}
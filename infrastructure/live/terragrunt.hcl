generate "versions" {
  path      = "versions.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}
EOF
}

## !!
generate "config" {
  path      = "config_generated.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
variable "user" {
  type        = string
  description = "Current user who's executing the plan"
}

variable "env" {
  type        = string
  description = "Environment"
}
EOF
}
terraform {
  extra_arguments "env" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh"
    ]

    arguments = [
      "-var", "user=${get_env("USER", "NOT_SET")}",
      "-var", "env=${get_env("TF_VAR_env", "dev")}", ## !!
    ]
  }
}

remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend_generated.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    resource_group_name  = "tfstate"
    storage_account_name = "terraform-stroage-account"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

generate "provider" {
  path      = "provider_generated.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  region = "westeurope" ## !!
}
EOF
}

locals {
  env    = "dev"
  region = "westeurope"
}
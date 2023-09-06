terraform {
  source = "../../../../../tf-modules//aci"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
}

inputs = {
  resource_group_location = local.env_vars.locals.region
  acr_username            = ""
  acr_password            = ""
  acr_server              = ""
}
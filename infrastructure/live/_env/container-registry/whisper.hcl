terraform {
  source = "../../../../../tf-modules//container-registry"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
}

inputs = {
  location                = local.env_vars.locals.region
  resource_group_name     = "container-registries"
  container-registry-name = "whisper"
}
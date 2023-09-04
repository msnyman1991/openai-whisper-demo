terraform {
  source = "../../../../tf-modules/aci"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
}

inputs = {
  container_group_name = "whisper-openapi"
  resource_group_name = "whisper"
  os_type = "Linux"
  location = local.env_vars.locals.env
}
terraform {
  source = "../../../../../tf-modules//aci"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
}

dependency "container_registry" {
  config_path = "../../container-registry/whisper"
  mock_outputs = {
    admin_username = "mock_username"
    admin_password = "mock_password"
    login_server   = "mock_server_name"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}

inputs = {
  resource_group_location = local.env_vars.locals.region
  location                = local.env_vars.locals.region
  acr_username            = dependency.container_registry.outputs.admin_username
  acr_password            = dependency.container_registry.outputs.admin_password
  acr_servername          = dependency.container_registry.outputs.login_server
}
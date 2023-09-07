terraform {
  source = "../../../../../tf-modules//virtual-network"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
}

inputs = {
  location             = local.env_vars.locals.region
  resource_group_name  = "networking"
  virtual_network_name = "whisper-network"
  private_subnet_name  = "private-subnet"
}

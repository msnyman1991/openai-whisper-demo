include "root" {
  path = find_in_parent_folders()
}

include "region" {
  path = find_in_parent_folders("region.hcl")
}

include "env" {
  path = "${get_terragrunt_dir()}/../../../../_env/networking/virtual-network.hcl"
}

inputs = {
  virtual_network_cidr     = ["10.0.0.0/16"]
  private_address_prefixes = ["10.0.1.0/24"]
  public_address_prefixes  = ["10.0.2.0/24"]
}
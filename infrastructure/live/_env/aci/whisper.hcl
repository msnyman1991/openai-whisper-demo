terraform {
  source = "../../../../../tf-modules//aci"
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
}

inputs = {

}

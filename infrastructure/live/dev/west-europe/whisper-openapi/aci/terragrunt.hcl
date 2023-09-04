include "root" {
  path = find_in_parent_folders()
}

include "region" {
  path = find_in_parent_folders("region.hcl")
}

include "env" {
  path = "${get_terragrunt_dir()}/../../../../_env/whisper-openapi/aci.hcl"
}
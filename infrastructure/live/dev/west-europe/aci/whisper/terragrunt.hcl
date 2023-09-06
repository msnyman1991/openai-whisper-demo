include "root" {
  path = find_in_parent_folders()
}

include "region" {
  path = find_in_parent_folders("region.hcl")
}

include "env" {
  path = "${get_terragrunt_dir()}/../../../../_env/aci/whisper.hcl"
}

inputs = {
  resource_group_name_prefix  = "rg"
  container_group_name_prefix = "acigroup"
  container_name_prefix       = "aci"
  image                       = "whisperujwrf.azurecr.io/whisperujwrf.azurecr.io/whisper-image:latest"
  port                        = "80"
  cpu_cores                   = "1"
  memory_in_gb                = "2"
}
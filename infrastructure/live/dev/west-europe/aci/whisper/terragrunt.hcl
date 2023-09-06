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
  resource_group_name_prefix  = "whisper_rg"
  container_group_name_prefix = "whisper_acigroup"
  container_name_prefix       = "whisper-asr-webservice"
  image                       = "whisper.azurecr.io/whisper.azurecr.io/whisper-image:latest"
  port                        = "9000"
  cpu_cores                   = "1"
  memory_in_gb                = "2"
}
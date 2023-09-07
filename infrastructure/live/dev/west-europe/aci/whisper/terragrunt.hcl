include "root" {
  path = find_in_parent_folders()
}

include "region" {
  path = find_in_parent_folders("region.hcl")
}

include "env" {
  path = "${get_terragrunt_dir()}/../../../../_env/aci/whisper.hcl"
}

dependency "virtual_network" {
  config_path = "../../networking/virtual-network"
}

inputs = {
  resource_group_name_prefix       = "whisper_rg"
  container_group_name_prefix      = "whisper_acigroup"
  container_name_prefix            = "whisper-asr-webservice"
  image                            = "whisper.azurecr.io/whisper.azurecr.io/whisper-image:latest"
  port                             = "9000"
  cpu_cores                        = "1"
  memory_in_gb                     = "2"
  private_subnet_id                = dependency.virtual_network.outputs.private_subnet_id
  public_subnet_id                 = dependency.virtual_network.outputs.public_subnet_id
  whisper_monitor_actiongroup_name = "whisper_monitor_ag"
  whisper_monitor_actiongroup_short_name = "whisper_mag"
  email_receiver_name              = "Morne"
  email_receiver_address           = "mr.mornesnyman@gmail.com"
  whisper_monitor_alert_name       = "whisper_monitor_alerts"

  lb_resource_group_name = "whisper_lb_rg"
  public_ip_name         = "whisper_lb_ip"
  loadbalancer_name      = "whisper_lb"
  lb_frontend_name       = "whisper_lb_frontend"
  lb_backend_pool_name   = "whisper_lb_backend_pool"
  loadbalancer_rule      = "whisper_lb_rule"
}
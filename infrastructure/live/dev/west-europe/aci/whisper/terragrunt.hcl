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
  mock_outputs = {
    private_subnet_id = "/subscriptions/mock_subscription_id/resourceGroups/mock_resource_group_name/providers/Microsoft.Network/virtualNetworks/mock_virtual_network_name/subnets/mock_subnet_name"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}

inputs = {
  resource_group_name_prefix             = "whisper_rg"
  container_group_name_prefix            = "whisper_acigroup"
  container_name_prefix                  = "whisper-asr-webservice"
  image                                  = "whisper.azurecr.io/whisper.azurecr.io/whisper-image:latest"
  port                                   = "9000"
  cpu_cores                              = "1"
  memory_in_gb                           = "2"
  // private_subnet_id                      = dependency.virtual_network.outputs.private_subnet_id
  private_subnet_id_ag                   = dependency.virtual_network.outputs.private_subnet_id_ag
  whisper_monitor_actiongroup_name       = "whisper_monitor_ag"
  whisper_monitor_actiongroup_short_name = "whisper_mag"
  email_receiver_name                    = "Morne"
  email_receiver_address                 = "mr.mornesnyman@gmail.com"
  whisper_monitor_alert_name             = "whisper_monitor_alerts"

  app_gateway_rg_name                 = "whisper_app_gateway_rg"
  app_gateway_public_ip_name          = "whisper_app_gateway_public_ip"
  app_gateway_name                    = "whisper_app_gateway"
  app_gateway_frontend_port_name      = "whisper_app_gateway_frontend_port"
  app_gateway_frontend_ip_config_name = "whisper_app_gateway_frontend_ip_config"
  app_gateway_ip_config_name          = "whisper_app_gateway_ip_config_name"
  dns_name_label                      = "whisper-asr-webservice"
}
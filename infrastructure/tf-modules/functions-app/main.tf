resource "azurerm_resource_group" "this" {
  name     = "scale-container-instances-rg"
  location = var.location
}

resource "azurerm_app_service_plan" "this" {
  name                = "scalecontainerinstances"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  kind                = "FunctionApp"
  reserved            = true

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_linux_function_app" "this" {
  name                = "scale-container-instances"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  app_service_plan_id = azurerm_app_service_plan.this.id
  os_type             = "Linux"
  runtime_stack       = "python"
  runtime_version     = "3.9"

  app_settings = {
    "FUNCTIONS_EXTENSION_VERSION" = "~3"
    "FUNCTIONS_WORKER_RUNTIME"    = "python"
    "MY_FUNCTION_CODE"            = <<-EOT
     import azure.functions as func
     from azure.identity import DefaultAzureCredential
     from azure.mgmt.containerinstance import ContainerInstanceManagementClient
     from azure.mgmt.containerinstance.models import ContainerGroup, Container

     def main(req: func.HttpRequest) -> func.HttpResponse:
         # Authenticate using Azure AD credentials or other supported methods
         credential = DefaultAzureCredential()
         aci_client = ContainerInstanceManagementClient(credential, "<Azure-Subscription-ID>")

         container_group_name = "whisper_acigroup"
         container_name = "whisper-1"
         container_image = "whisper.azurecr.io/whisper.azurecr.io/whisper-image:latest"
         container_resource_requests = {
             "cpu": "0.5",
             "memory_in_gb": "1.5"
         }

         container_ports = [
              {
                  "port": 9000
              }
          ]

         container = Container(
             name=container_name,
             image=container_image,
             resources=container_resource_requests
         )

         container_group_properties = ContainerGroup(
             os_type="Linux",
             containers=[container],
             location="${var.location}",
         )

         aci_client.container_groups.create_or_update(
             resource_group_name="whisper_rg-top-loon",
             container_group_name=container_group_name,
             container_group=container_group_properties
         )

         return func.HttpResponse("Container instance created successfully.")
     EOT
  }
}





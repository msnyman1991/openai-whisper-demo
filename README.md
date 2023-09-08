# openai-whisper-demo

# Architecture Diagram
<p align="center">
    <img src="https://github.com/msnyman1991/openai-whisper-demo/blob/main/whisper.png?raw=true" alt="centered image" />
</p>

# Deployment process

The GitHub repository encompasses both infrastructure code (Terraform/Terragrunt) and application code for the Whisper ASR Webservice. Whenever a change occurs in either the infrastructure or application code and is subsequently pushed to the repository, it automatically triggers the Azure DevOps pipeline.

This Azure DevOps pipeline comprises several stages:

1. Validation: This stage performs Terragrunt and Terraform formatting checks, along with Pylint for syntax validation of the application code.
2. TerragruntPlan: Here, a Terragrunt plan is executed for infrastructure deployment.
3. Terragrunt Approve: If the Terragrunt plan is accurate, an authorized user can grant approval.
4. DeployInfra: This stage is responsible for deploying the infrastructure.
5. BuildWhisper: It involves building a Docker image for the Whisper ASR Webservice and then pushing this image to the Azure Container Repository.
6. Deploy Whisper: Finally, this stage deploys the Azure Container Instance Group using the Whisper ASR Webservice Docker image from ACR, in conjunction with the Application Gateway.

# To Do
* Implement AutoScaling for Azure Container Instance Group, possibly using Azure Functions and Azure Monitor
* Implement propper storing of the Azure DevOps Pipeline Artifacts
* Implement additional testing for application code during Build and Deploy stage in the Azure DevOps pipeline
* Do a complete security audit of the implementation
* Investigate using other Azure Container Services such as AKS

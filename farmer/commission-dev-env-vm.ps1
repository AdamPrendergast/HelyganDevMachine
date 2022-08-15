# Description: Commission Dev Env VM
# Author: Helygan Digital

# Create Resource Group
az group create --name DevEnvGroup --location "UK West"

# Deploy ARM Template
az deployment group create --name DevEnvDeployment `
 --resource-group DevEnvGroup `
 --template-file ./arm/dev-env.json
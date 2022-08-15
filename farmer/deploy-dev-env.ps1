# Description: Deploy ARM Template
# Author: Helygan Digital

# Create Resource Group
az group create --name DevEnvGroup --location "UK West"

# Deploy ARM Template
az deployment group create --name DevEnvGroup `
 --resource-group ScriptedDeployment `
 --template-file ./arm/dev-env.json
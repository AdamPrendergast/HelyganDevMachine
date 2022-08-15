# Description: Helygan Development Axure Cli Scripts
# Author: Helygan Digital

# Create Resource Group
az group create --name ScriptedDeployment --location "UK West"

# Deploy ARM Template
az deployment group create --name ScriptedDeployment `
 --resource-group ScriptedDeployment `
 --template-file ./deployment/development-environment.json

# Initialize Data Disk
# Would need to run remote Powershell. See:
# https://docs.microsoft.com/en-us/azure/virtual-machines/windows/attach-disk-ps#initialize-the-disk

# Downgrade OS/Data Disks to HDD
# Upgrade OS/Data Disks to SSD
# Upgrade OS Disk to Premium SSD
# https://docs.microsoft.com/en-us/azure/virtual-machines/linux/convert-disk-storage

# Upgrade Machine to Standard_D4ds_v4
# Downgrade Machine to Standard_B2s

# Restart VM

### Reference
# https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-cli
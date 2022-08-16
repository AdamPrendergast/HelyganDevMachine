# #Choose between Standard_LRS, StandardSSD_LRS and Premium_LRS based on your scenario
# $osSku='Premium_LRS'
# $dataSku='StandardSSD_LRS'

# #Deallocate the VM before changing the size of the VM
# az vm deallocate --resource-group $rgName --name $vmName

# # Update the SKU
# az disk update --sku $osSku --name $oSDiskName --resource-group $rgName
# az disk update --sku $dataSku --name $dataDiskName --resource-group $rgName

# az vm start --resource-group $rgName --name $vmName
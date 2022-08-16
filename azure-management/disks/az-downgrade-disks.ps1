# #Choose between Standard_LRS, StandardSSD_LRS and Premium_LRS based on your scenario
# $sku='Standard_LRS'

# #Get the parent VM Id 
# #vmId=$(az disk show --name $oSDiskName --resource-group $rgName --query managedBy --output tsv)

# #Deallocate the VM before changing the size of the VM
# #az vm deallocate --ids $vmId
# az vm deallocate --resource-group $rgName --name $vmName

# #Change the VM size to a size that supports Premium storage 
# #Skip this step if converting storage from Premium to Standard
# # az vm resize --ids $vmId --size $size

# # Update the SKU
# az disk update --sku $sku --name $oSDiskName --resource-group $rgName
# az disk update --sku $sku --name $dataDiskName --resource-group $rgName

# az vm start --resource-group $rgName --name $vmName
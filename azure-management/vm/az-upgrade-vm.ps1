# #Premium Disk capable size 
# $size='Standard_D4ds_v4'

# #Deallocate the VM before changing the size of the VM
# az vm deallocate --resource-group $rgName --name $vmName

# #Change the VM size
# az vm resize --resource-group $rgName --name $vmName --size $size

# #Start the VM size
# az vm start --resource-group $rgName --name $vmName
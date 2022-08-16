# #Resource group & VM Name
# # $rgName='DevEnvGroup'
# # $vmName='HD-Dev-VM'

# #Premium Disk capable size 
# $size='Standard_B8ms'

# #Deallocate the VM before changing the size of the VM
# az vm deallocate --resource-group $rgName --name $vmName

# #Change the VM size
# az vm resize --resource-group $rgName --name $vmName --size $size

# #Start the VM size
# az vm start --resource-group $rgName --name $vmName
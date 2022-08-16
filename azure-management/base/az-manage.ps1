
function Update-VMSize {
    param (
        [Parameter(Mandatory = $true)] [string] $VMSize
    )
    # Deallocate the VM
    az vm deallocate --resource-group $rgName --name $vmName
    # Change the VM size
    az vm resize --resource-group $rgName --name $vmName --size $VMSize
    # Start the VM
    az vm start --resource-group $rgName --name $vmName
}

function Update-DiskType {
    param (
        [Parameter(Mandatory = $true)] [string] $DiskName,
        [Parameter(Mandatory = $true)] [string] $DiskType
    )
    # Deallocate the VM
    az vm deallocate --resource-group $rgName --name $vmName
    # Update the SKU
    az disk update --sku $DiskType --name $DiskName --resource-group $rgName
    # Start the VM
    az vm start --resource-group $rgName --name $vmName
}
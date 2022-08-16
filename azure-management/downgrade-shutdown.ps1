. .\base\az-settings.ps1
. .\base\az-manage.ps1

. .\downgrade.ps1

az vm deallocate --resource-group $rgName --name $vmName

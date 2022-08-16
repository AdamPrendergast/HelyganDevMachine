. .\base\az-settings.ps1
. .\base\az-manage.ps1

Update-VMSize -VMSize $midSpecVM
Update-DiskType -DiskName $osDiskName -DiskType $premiumSSD
Update-DiskType -DiskName $dataDiskName -DiskType $standardSSD

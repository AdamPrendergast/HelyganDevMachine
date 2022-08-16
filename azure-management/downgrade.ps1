. .\base\az-settings.ps1
. .\base\az-manage.ps1

Update-VMSize -VMSize $lowSpecVM
Update-DiskType -DiskName $osDiskName -DiskType $standardHDD
Update-DiskType -DiskName $dataDiskName -DiskType $standardHDD

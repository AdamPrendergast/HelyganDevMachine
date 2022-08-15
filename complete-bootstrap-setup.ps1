# Description: Complete Bootstrap Setup
# Author: Helygan Digital


$o = new-object -com shell.application
$o.Namespace('c:\provision').Self.InvokeVerb("pintohome")


#--- Final Server Housekeeping ---
#Set home location to United Kingdom
Set-WinHomeLocation 0xf2
#Override language list with just English GB
$1 = New-WinUserLanguageList en-GB
$1[0].Handwriting = 1
Set-WinUserLanguageList $1 -force
#Set system local
Set-WinSystemLocale en-GB
#Set the timezone
Set-TimeZone "GMT Standard Time"
# Set Network Discovery to 'No'
netsh advfirewall firewall set rule group=”Network Discovery” new enable=No

#--- Configuring Windows properties ---
#--- Windows Features ---
# Show hidden files, Show protected OS files, Show file extensions
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions

# #--- Initialise any Data Disks ---
$disks = Get-Disk | Where partitionstyle -eq 'raw' | sort number

    $letters = 70..89 | ForEach-Object { [char]$_ }
    $count = 0
    $labels = "Data","Data-2"

    foreach ($disk in $disks) {
        $driveLetter = $letters[$count].ToString()
        $disk |
        Initialize-Disk -PartitionStyle MBR -PassThru |
        New-Partition -UseMaximumSize -DriveLetter $driveLetter |
        Format-Volume -FileSystem NTFS -NewFileSystemLabel $labels[$count] -Confirm:$false -Force
	$count++
    }

# #--- reenabling critial items ---
Enable-UAC

# # Install-WindowsUpdate -AcceptEula 

# Restart-Computer
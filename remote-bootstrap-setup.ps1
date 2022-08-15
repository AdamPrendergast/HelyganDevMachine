# Description: Helygan Development Machine Script
# Author: Helygan Digital

# Install Chocolatey
Set-ExecutionPolicy -Scope CurrentUser Unrestricted
Set-ExecutionPolicy Unrestricted
iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex

Get-PackageProvider -Name chocolatey -Force
Get-PackageProvider -Name nuget -Force

$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).Path)\..\.."   
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

# Install Box Starter
choco install -y boxstarter
refreshenv

Disable-UAC

#--- Enable developer mode on the system ---
Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense -Value 1

#--- File Explorer Settings ---
# will expand explorer to the actual folder you're in
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
#adds things back in your left pane like recycle bin
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
#opens PC to This PC, not quick access
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
#taskbar where window is open for multi-monitor
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

#--- Windows Server Tidy Up ---
# prevent Server Manager loading on login
Get-ScheduledTask -TaskName ServerManager | Disable-ScheduledTask -Verbose

# Install Windows Features
choco install -y IIS-WebServerRole --source WindowsFeatures
choco install -y IIS-ISAPIFilter --source WindowsFeatures
choco install -y IIS-ISAPIExtensions --source WindowsFeatures
choco install -y IIS-NetFxExtensibility --source WindowsFeatures
choco install -y IIS-ASPNET --source WindowsFeatures

# # Install Utilities
choco install -y powershell-core
# choco install -y microsoft-windows-terminal // Currently an issue with this (installing dependancy 'Microsoft.VCLibs.140.00.UWPDesktop') see: https://community.chocolatey.org/packages/microsoft-windows-terminal
choco install -y git --package-parameters="'/GitAndUnixToolsOnPath /WindowsTerminal'"
choco install -y 7zip.install
choco install -y urlrewrite
refreshenv # Refresh to bring in any installed env variables (eg. git)

# # Install Browsers
choco install -y setdefaultbrowser
choco install -y googlechrome
choco install -y firefox
SetDefaultBrowser.exe chrome

# # Install Software
choco install -y vscode
choco install -y gitkraken
choco install -y papercut
# refreshenv

# # Bootstrap Provision Repo
cd C:/
mkdir provision
cd provision
git clone https://github.com/AdamPrendergast/HelyganDevMachine.git
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
    $labels = "Data-1","Data-2"

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
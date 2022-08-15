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

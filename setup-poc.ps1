# Description: Helygan Development Machine Script
# Author: Helygan Digital

# Install Chocolatey
Set-ExecutionPolicy -Scope CurrentUser Unrestricted
Set-ExecutionPolicy Unrestricted
iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex

Get-PackageProvider -Name chocolatey -Force

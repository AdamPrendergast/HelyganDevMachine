# Install Chocolatey
Set-ExecutionPolicy -Scope CurrentUser Unrestricted
Set-ExecutionPolicy Unrestricted
iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex

Get-PackageProvider -Name chocolatey
Get-PackageProvider -Name nuget

# Install Box Starter
choco install -y boxstarter
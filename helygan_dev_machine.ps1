# Description: Helygan Development Machine Script
# Author: Helygan Digital

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	iex -Command ".\scripts/$script"
}

#--- Bootstrap ---
executeScript "Bootstrap.ps1";

#--- Provision ---
Disable-UAC
executeScript "SystemConfiguration.ps1";
executeScript "FileExplorerSettings.ps1";
executeScript "RemoveDefaultApps.ps1";
executeScript "CommonDevTools.ps1";

#--- Tools ---
#--- Installing VS and VS Code with Git
# See this for install args: https://chocolatey.org/packages/VisualStudio2017Community
# https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-community
# https://docs.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio#list-of-workload-ids-and-component-ids
# visualstudio2017community
# visualstudio2017professional
# visualstudio2017enterprise

choco install -y visualstudio2022community --package-parameters="'--add Microsoft.VisualStudio.Component.Git'"
Update-SessionEnvironment #refreshing env due to Git install

# executeScript "WindowsTemplateStudio.ps1";
# executeScript "GetUwpSamplesOffGithub.ps1";

#--- reenabling critial items ---
Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula

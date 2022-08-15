# Description: Install Visual Studio
# Author: Helygan Digital

choco install visualstudio2022community -y --package-parameters "--add Microsoft.VisualStudio.Workload.Azure;includeRecommended;includeOptional --add Microsoft.VisualStudio.Workload.NetWeb;includeRecommended;includeOptional --add Microsoft.VisualStudio.Workload.Node;includeRecommended;includeOptional"
refreshenv
choco install -y resharper
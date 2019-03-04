# ARM Templates: Tools to start with

This page contains a list of tools you can use to start moving first steps on ARM Templates world.
It doesn't want to be a complete list, and probably you can find better instruments or configurations more suitable for you, but this is just what I use.

* **[Visual Studio Code](https://code.visualstudio.com/)** with:
  * Azure Tools extension
  * PowerShell extension
  * ARM snippets loaded (follow [these](https://github.com/Azure/azure-xplat-arm-tooling) instructions)
* **PowerShell** - at least 5.1 version to have a rich experience with DSC configurations - or **Azure Cloud Shell**. On PowerShell it's advisable to install [Az module](https://docs.microsoft.com/en-us/powershell/azure/new-azureps-module-az?view=azps-1.4.0) by executing `Install-Module Az`. After installation, if compatibility with AzureRm module is required, execute the cmdlet `Enable-AzureRmAlias`
* A public or private **repository** for templates/artifacts; it can be a GitHub repo as well as a simple storage account.
* [ARM Template reference](https://docs.microsoft.com/en-us/azure/templates/)
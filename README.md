# StartingWithArmTemplates

This repo contains demo scripts I'm using to explain ARM templates concepts on different conferences.  
It will receive additional contents during time, to adapt it to different scenarios.

Here the list of contents you can find in the folders provided:
- **00_Tools**: a list of tools and settings I used to produce ARM templates. You can choose different ones, but I'm feeling confortable with them :simple_smile:
- **01_Arm_Template_Structure**: this folder actually contains an empty json file, which I use to demonstrate the use of different template sections create by snippets via VSCODE.
- **02_SimpleTemplate**: A template which deploy a simple storage account, with a PoSH deployment script which launch it with or without a parameters file.
- **03_Troubleshooting**: A couple of problematic ARM Templates, which I use to demonstrate a syntax error, which is fast to be raised by the parser, and a formal error is raised only when the wrong resource is effectively deployed.
- **04_AdvancedScenarios**: in this folder you can find:
    - A monolitic template which deploy a WebApp with deployment slots, related Application Insights settings and a SQL Azure Database.
    - A nested template, which deploy same resources as above, to illustrate ARM templates reusability.
    - A template which demonstrate a resource update during the template deployment (first deploy a Vnet, then attach a NIC to it and update the Vnet specifying DNS settings to reflect the IP address assigned to the NIC).
    - A template which can deploy a simple single instance DEV environment, as well as a geo-distributed PROD environment by changing a single parameters. It shows how you can leverage on json objects inside variables and how you can iterate on them with copy loops to create a different numbers of variables, depending on the number of array elements. The outcome of the template is depicted in differentEnv.jpg.
    - A couple of simple templates which use Output section to debug object concatenation.
- **05_DSC_Domain_Join**: a series of templates which shown how you can leverage on DSC config to join an IaaS VM to an Active Directory domain.
- **06_CSE_example**: a simple custom script extension demo, which deploy and execute a PowerShell script inside an IaaS VM.

## Sessions
**Azure Saturday 2018**, Pordenone, 06/10/2018  
[Slides on SlideShare](https://www.slideshare.net/MarcoObinu/azure-saturday-automatizzare-la-creazione-di-risorse-con-arm-templates-e-powershell-marco-obinu/MarcoObinu/azure-saturday-automatizzare-la-creazione-di-risorse-con-arm-templates-e-powershell-marco-obinu)  
[Video on YouTube](https://youtu.be/fgLxGtxdstk)

**Cloud Conference Italia 2018**, Quinto di Treviso, 07/11/2018
*Slide will be available for attendes via [official event site](www.cloudconferenceitalia.it)*
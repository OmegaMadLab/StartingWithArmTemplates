# StartingWithArmTemplates

This repo contains demo scripts I'm using to explain ARM templates concepts on different conferences.  
It will receive additional contents during time, to adapt it to different scenarios.

Here the list of contents you can find in the folders provided:
- **00_Tools**: a list of tools and settings I used to produce ARM templates. You can choose different ones, but I'm feeling confortable with them :simple_smile:
- **01_Arm_Template_Structure**: this folder actually contains an empty json file, which I use to demonstrate the use of different template sections create by snippets via VSCODE.
- **02_SimpleTemplate**: Two templates which deploy a simple storage account and an Azure SQL Database with related SQL Server logical server and a firewall rule, with a PoSH deployment script which launch it with or without a parameters file.
- **03_Troubleshooting**: A couple of problematic ARM Templates, which I use to demonstrate a syntax error, which is fast to be raised by the parser, and a formal error is raised only when the wrong resource is effectively deployed.
- **04_AdvancedScenarios**: in this folder you can find:
    - A monolitic template which deploy a WebApp with deployment slots, related Application Insights settings and a SQL Azure Database.
    - A nested template, which deploy same resources as above, to illustrate ARM templates reusability.
    - A template which demonstrate a resource update during the template deployment (first deploy a Vnet, then attach a NIC to it and update the Vnet specifying DNS settings to reflect the IP address assigned to the NIC).
    - Two templates which can deploy a simple single instance DEV environment, as well as a geo-distributed PROD environment by changing a single parameters, focused one on App Services (geo-distributed webapp with traffic manager) and the other on Azure SQL Database (geo-distributed database failover group). They shows how you can leverage on json objects inside variables and how you can iterate on them with copy loops to create a different numbers of variables, depending on the number of array elements. The outcome of the template is depicted in differentEnv.jpg and sqlDifferentEnv.jpg.
    - A couple of simple templates which use Output section to debug object concatenation.
- **05_DSC_example**: a series of templates which shown how you can leverage on DSC config to join an IaaS VM to an Active Directory domain or to apply SQL Server configurations with SqlServerDsc module.
- **06_CSE_example**: a series of templates related to custom script extension demo, which deploy and execute a PowerShell script inside an IaaS VM. On the SQL Server context, you can find some example on how to leverage on CredSSP to execute command by impersonating a different user, to gain access to SQL Server. You can also find an example on how to use a DSC configuration to launch a custom script; in this way you can use PSDscRunAsCredential to impersonate a different user, without altering the register in order to activate CredSSP.

## Sessions
**Azure Saturday 2018**, Pordenone, 06/10/2018  
[Slides on SlideShare](https://www.slideshare.net/MarcoObinu/azure-saturday-automatizzare-la-creazione-di-risorse-con-arm-templates-e-powershell-marco-obinu/MarcoObinu/azure-saturday-automatizzare-la-creazione-di-risorse-con-arm-templates-e-powershell-marco-obinu)  
[Video on YouTube](https://youtu.be/fgLxGtxdstk)

**Cloud Conference Italia 2018**, Quinto di Treviso, 07/11/2018
[Slides on SlideShare](https://www.slideshare.net/walk2talk/cci2018-automatizzare-la-creazione-di-risorse-con-arm-template-e-powershell)

**SQL Saturday 777**, Parma, 24/11/2018
[Slides](https://www.sqlsaturday.com/777/Sessions/Details.aspx?sid=84868)
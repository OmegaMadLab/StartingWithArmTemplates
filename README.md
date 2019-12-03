# StartingWithArmTemplates

This repo contains demo scripts I've used to explain ARM templates concepts at different conferences.  
It will receive additional content during the time, to adapt it to different scenarios.

Here the list of contents you can find in the folders provided:

- **00_Tools**: a list of tools and settings I used to produce ARM templates. You can choose different ones, but I'm feeling comfortable with them. :grin:
- **01_Arm_Template_Structure**: this folder contains an empty JSON file, which I use to demonstrate the use of different template sections created by snippets via VSCODE.
- **02_SimpleTemplate**: Two templates that deploy a single storage account and an Azure SQL Database with related SQL Server logical server and a firewall rule. A PoSH deployment script executes them with or without a parameter file.
- **03_Troubleshooting**: A couple of problematic ARM Templates, which I use to demonstrate different errors: a syntax error, fast to be raised by the parser, and a formal error only raised when the ARM backend deploys the bad resource.
In this folder you can also find some examples about how to use the Output section of the template to test string concatenation and similar scenarios.
- **04_AdvancedScenarios**: In this folder you can find:
  - a monolithic template that distributes a single WebApp with multiple deployment slots, including related Application Insights settings and a SQL Azure Database.
  - a nested template, that deploys the same resources as above, to illustrate ARM templates reusability.
  - a template that implements a resource update during the deployment flow. It first deploys a Vnet, then attaches a NIC to it and update the Vnet specifying DNS settings to reflect the IP address assigned to the NIC).
  - two templates that can deploy a simple, single instance DEV environment or a geo-distributed PROD environment by changing an only parameters. One deploy App Services (geo-distributed web app with traffic manager) and the other an Azure SQL Database (geo-distributed database failover group). They show how you can leverage on JSON objects inside variables and how you can iterate on them with copy loops to create a different number of variables, depending on the number of array elements. The pictures named differentEnv.jpg and sqlDifferentEnv.jpg depict the outcome of different templates.
  - a couple of simple templates that use the Output section to debug object concatenation.
- **05_CSE_example**: a series of templates related to custom script extension demo, which deploy and execute a PowerShell script inside an IaaS VM. On the SQL Server context, you can find some examples on how to leverage on CredSSP to execute commands by impersonating a different user, to gain access to SQL Server
- **06_DSC_example**: a series of templates that show how you can leverage on DSC config to join an IaaS VM to an Active Directory domain or to apply SQL Server configurations with SqlServerDsc module. You can also find an example on how to use a DSC configuration to launch a custom script; in this way, you can use PSDscRunAsCredential to impersonate a different user, without altering the register to activate CredSSP.

## Sessions
**Azure Saturday 2018**, Pordenone, 06/10/2018  
[Slides on SlideShare](https://www.slideshare.net/MarcoObinu/azure-saturday-automatizzare-la-creazione-di-risorse-con-arm-templates-e-powershell-marco-obinu/MarcoObinu/azure-saturday-automatizzare-la-creazione-di-risorse-con-arm-templates-e-powershell-marco-obinu)  
[Video on YouTube](https://youtu.be/fgLxGtxdstk)

**Cloud Conference Italia 2018**, Quinto di Treviso, 07/11/2018
[Slides on SlideShare](https://www.slideshare.net/walk2talk/cci2018-automatizzare-la-creazione-di-risorse-con-arm-template-e-powershell)

**SQL Saturday 777**, Parma, 24/11/2018
[Slides](https://www.sqlsaturday.com/777/Sessions/Details.aspx?sid=84868)

**WPC Italia 2019**, Milano, 03/12/2019
Material distrubuted by the event organizer.

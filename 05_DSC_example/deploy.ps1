$HelperModulePath = (Get-Item "..\99_HelperScripts\ArmTemplateDemoPsUtilities.psm1").FullName
Import-Module $HelperModulePath

##### Domain join example

### PREREQ

# Create a new AD forest on a brand new VM
$RgName = "ActiveDirectory-RG"
$Rg = Set-AzureRg -Name $RgName

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateUri "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/active-directory-new-domain/azuredeploy.json" `
    -adminUserName "contosoAdmin" `
    -adminPassword $(ConvertTo-SecureString -AsPlainText "Passw0rd1" -Force) `
    -domainName "contoso.local" `
    -dnsPrefix "contosodemodc" `
    -AsJob

### Example 1

# Deploy a VM which will join the domain via template
$RgName = "ArmDemo-DomainJoin-RG"
$Rg = Set-AzureRg -Name $RgName

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\newVm-domainJoin.json).FullName `
    -TemplateParameterFile (Get-Item .\newVm-domainJoin.parameters.json).FullName `
    -AsJob

### Example 2

# Deploy a VM not joined to the domain
$RgName = "ArmDemo-NotJoined-RG"
$Rg = Set-AzureRg -Name $RgName

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\newVm-toBeJoined.json).FullName `
    -TemplateParameterFile (Get-Item .\newVm-toBeJoined.parameters.json).FullName

## Deploy a DSC resource on an existing VM
New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\DSC-domainJoin.json).FullName `
    -TemplateParameterFile (Get-Item .\DSC-domainJoin.parameters.json).FullName



##### SQL Server example

### Example 1

# Deploy a SQL VM with a new SQL login with sysadmin privileges and MaxDOP = 1 via template
$RgName = "ArmDemo-SqlIaasIntegration-RG"
$Rg = Set-AzureRg -Name $RgName

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\newSqlVm-dscConfigApplied.json).FullName `
    -TemplateParameterFile (Get-Item .\newSqlVm-dscConfigApplied.parameters.json).FullName `
    -AsJob

### Example 2

# Deploy a SQL VM
$RgName = "ArmDemo-SqlIaasIntegration2-RG"
$Rg = Set-AzureRg -Name $RgName

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\newSqlVm.json).FullName `
    -TemplateParameterFile (Get-Item .\newSqlVm.parameters.json).FullName `
    -AsJob

## Deploy a DSC resource which adds a new SQL login with sysadmin privileges and sets MaxDOP = 1 on an existing VM
New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\DSC-domainJoin.json).FullName `
    -TemplateParameterFile (Get-Item .\DSC-domainJoin.parameters.json).FullName

$HelperModulePath = (Get-Item "..\99_HelperScripts\ArmTemplateDemoPsUtilities.psm1").FullName
Import-Module $HelperModulePath

##### Domain join example

### Example 1

# Deploy a VM that will join the domain via template
$RgName = "ArmDemo-DomainJoin-RG"
$Rg = Set-AzureRg -Name $RgName

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\newVm-domainJoin.json).FullName `
    -TemplateParameterFile (Get-Item .\newVm-domainJoin.parameters.json).FullName `
    -AsJob

### Demo Cleanup
Remove-AzResourceGroup -Name $RgName `
    -Force `
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

### Demo Cleanup
Remove-AzResourceGroup -Name $RgName `
    -Force `
    -AsJob

##### SQL Server examples

### Example 1

# Deploy a SQL VM with a new SQL login with sysadmin privileges and MaxDOP = 1 via template
$RgName = "ArmDemo-SqlIaasIntegration-RG"
$Rg = Set-AzureRg -Name $RgName

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\newSqlVm-dscConfigApplied.json).FullName `
    -TemplateParameterFile (Get-Item .\newSqlVm-dscConfigApplied.parameters.json).FullName `
    -AsJob

### Demo Cleanup
Remove-AzResourceGroup -Name $RgName `
    -Force `
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
    -TemplateFile (Get-Item .\DSC-sqlConfig.json).FullName `
    -TemplateParameterFile (Get-Item .\DSC-sqlConfig.parameters.json).FullName

### Demo Cleanup
Remove-AzResourceGroup -Name $RgName `
    -Force `
    -AsJob

    

#### SQL Example - DSC resource "hack" to launch a custom script
### Example 1
#Deploy a VM which will execute the "hacked" DSC
$RgName = "ArmDemo-SqlIaasIntegration4-RG"
$Rg = Set-AzureRg -Name $RgName

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\newSqlVm-dscAsCustomScriptApplied.json).FullName `
    -TemplateParameterFile (Get-Item .\newSqlVm-dscAsCustomScriptApplied.parameters.json).FullName `
    -AsJob

### Demo Cleanup
Remove-AzResourceGroup -Name $RgName `
    -Force `
    -AsJob

### Example 2
# Deploy a SQL VM
$RgName = "ArmDemo-SqlIaasIntegration5-RG"
$Rg = Set-AzureRg -Name $RgName

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\newSqlVm.json).FullName `
    -TemplateParameterFile (Get-Item .\newSqlVm-2.parameters.json).FullName `
    -AsJob

## Deploy the "hacked" DSC extension on an existing VM - Using one of the VM generated during previous examples
$RgName = "ArmDemo-SqlIaasIntegration5-RG"
$Rg = Set-AzureRg -Name $RgName

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\DSC-customScript.json).FullName `
    -TemplateParameterFile (Get-Item .\DSC-customScript.parameters.json).FullName

### Demo Cleanup
Remove-AzResourceGroup -Name $RgName `
    -Force `
    -AsJob

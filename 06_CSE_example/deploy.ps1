$HelperModulePath = (Get-Item "..\99_HelperScripts\ArmTemplateDemoPsUtilities.psm1").FullName
Import-Module $HelperModulePath

### Example 1

#Deploy a VM which will execute the CSE
RgName = "ArmDemo-CSE-RG"
$Rg = Set-AzureRg -Name $RgName

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\newVm-withCSE.json).FullName `
    -TemplateParameterFile (Get-Item .\newVm-withCSE.parameters.json).FullName

### Example 2

## Deploy the CSE resource on an existing VM - Using one of the VM generated during previous examples
$RgName = "ArmDemo-DomainJoin-RG"
$Rg = Set-AzureRg -Name $RgName

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\CSE-ReadFile.json).FullName `
    -TemplateParameterFile (Get-Item .\CSE-ReadFile.parameters.json).FullName


#### SQL Examples

### Example 1

#Deploy a VM which will execute the CSE
$RgName = "ArmDemo-SqlIaasIntegration-RG"
$Rg = Set-AzureRg -Name $RgName

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\newSqlVm-CseConfigApplied.json).FullName `
    -TemplateParameterFile (Get-Item .\newSqlVm-CseConfigApplied.parameters.json).FullName

### Example 2

# Deploy a SQL VM
$RgName = "ArmDemo-SqlIaasIntegration3-RG"
$Rg = Set-AzureRg -Name $RgName

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\newSqlVm.json).FullName `
    -TemplateParameterFile (Get-Item .\newSqlVm.parameters.json).FullName `
    -AsJob

## Deploy the CSE resource on an existing VM - Using one of the VM generated during previous examples
$RgName = "ArmDemo-SqlIaasIntegration3-RG"
$Rg = Set-AzureRg -Name $RgName

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\CSE-sqlConfig.json).FullName `
    -TemplateParameterFile (Get-Item .\CSE-sqlConfig.parameters.json).FullName


#### SQL Example - DSC resource "hack" to launch a custom script
### Example 1
#Deploy a VM which will execute the "hacked" DSC
$RgName = "ArmDemo-SqlIaasIntegration4-RG"
$Rg = Set-AzureRg -Name $RgName

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\newSqlVm-dscAsCustomScriptApplied.json).FullName `
    -TemplateParameterFile (Get-Item .\newSqlVm-dscAsCustomScriptApplied.parameters.json).FullName `
    -AsJob

### Example 2
# Deploy a SQL VM
$RgName = "ArmDemo-SqlIaasIntegration5-RG"
$Rg = Set-AzureRg -Name $RgName

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\newSqlVm.json).FullName `
    -TemplateParameterFile (Get-Item .\newSqlVm.parameters.json).FullName `
    -AsJob

## Deploy the "hacked" DSC extension on an existing VM - Using one of the VM generated during previous examples
$RgName = "ArmDemo-SqlIaasIntegration5-RG"
$Rg = Set-AzureRg -Name $RgName

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\DSC-customScript.json).FullName `
    -TemplateParameterFile (Get-Item .\DSC-customScript.parameters.json).FullName
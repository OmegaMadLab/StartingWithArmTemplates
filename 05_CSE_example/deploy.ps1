$HelperModulePath = (Get-Item "..\99_HelperScripts\ArmTemplateDemoPsUtilities.psm1").FullName
Import-Module $HelperModulePath

### Example 1

#Deploy a VM which will execute the CSE
$RgName = "ArmDemo-CSE-RG"
$Rg = Set-AzureRg -Name $RgName

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\newVm-withCSE.json).FullName `
    -TemplateParameterFile (Get-Item .\newVm-withCSE.parameters.json).FullName

### Demo Cleanup
Remove-AzResourceGroup -Name $RgName `
    -Force `
    -AsJob

### Example 2

## Deploy the CSE resource on an existing VM - Using one of the VM generated during previous examples
$RgName = "ArmDemo-DomainJoin-RG"
$Rg = Set-AzureRg -Name $RgName

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\CSE-ReadFile.json).FullName `
    -TemplateParameterFile (Get-Item .\CSE-ReadFile.parameters.json).FullName

### Demo Cleanup
Remove-AzResourceGroup -Name $RgName `
    -Force `
    -AsJob


#### SQL Examples

### Example 1

#Deploy a VM which will execute the CSE
$RgName = "ArmDemo-SqlIaasIntegration-RG"
$Rg = Set-AzureRg -Name $RgName

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\newSqlVm-CseConfigApplied.json).FullName `
    -TemplateParameterFile (Get-Item .\newSqlVm-CseConfigApplied.parameters.json).FullName

### Demo Cleanup
Remove-AzResourceGroup -Name $RgName `
    -Force `
    -AsJob

### Example 2

# Deploy a SQL VM
$RgName = "ArmDemo-SqlIaasIntegration3-RG"
$Rg = Set-AzureRg -Name $RgName

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\newSqlVm.json).FullName `
    -TemplateParameterFile (Get-Item .\newSqlVm.parameters.json).FullName `
    -AsJob

### Demo Cleanup
Remove-AzResourceGroup -Name $RgName `
    -Force `
    -AsJob

## Deploy the CSE resource on an existing VM - Using one of the VM generated during previous examples
$RgName = "ArmDemo-SqlIaasIntegration3-RG"
$Rg = Set-AzureRg -Name $RgName

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\CSE-sqlConfig.json).FullName `
    -TemplateParameterFile (Get-Item .\CSE-sqlConfig.parameters.json).FullName

### Demo Cleanup
Remove-AzResourceGroup -Name $RgName `
    -Force `
    -AsJob



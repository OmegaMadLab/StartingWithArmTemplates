$HelperModulePath = (Get-Item "..\99_HelperScripts\ArmTemplateDemoPsUtilities.psm1").FullName
Import-Module $HelperModulePath

$RgName = "ArmDemo-Troubleshoot-RG"
$Rg = Set-AzureRg -Name $RgName

## Validation error: variable not defined
New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\newVm-validationError.json).FullName `
    -TemplateParameterFile (Get-Item .\newVm.parameters.json).FullName

## Formal error: trying to deploy a standard Windows image on a small disk
New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\newVm-resourceError.json).FullName `
    -TemplateParameterFile (Get-Item .\newVm.parameters.json).FullName `
    -asJob

## Input validation
New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\parameterValidation.json).FullName 
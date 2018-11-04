$DemoRgName = "ArmDemo-Troubleshoot-RG"
New-AzResourceGroup -Name $DemoRgName -Location "westeurope"

## Validation error: variable not defined
New-AzResourceGroupDeployment -ResourceGroupName $DemoRgName `
    -TemplateFile (Get-Item .\newVm-validationError.json).FullName `
    -TemplateParameterFile (Get-Item .\newVm.parameters.json).FullName

## Formal error: trying to deploy a standard Windows image on a small disk
New-AzResourceGroupDeployment -ResourceGroupName $DemoRgName `
    -TemplateFile (Get-Item .\newVm-resourceError.json).FullName `
    -TemplateParameterFile (Get-Item .\newVm.parameters.json).FullName

## Input validation
New-AzResourceGroupDeployment -ResourceGroupName $DemoRgName `
    -TemplateFile (Get-Item .\parameterValidation.json).FullName 
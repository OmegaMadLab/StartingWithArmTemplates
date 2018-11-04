### Example 1

#Deploy a VM which will execute the CSE
$DemoRgName = "ArmDemo-CSE-RG"
New-AzResourceGroup -Name $DemoRgName -Location "westeurope"

New-AzResourceGroupDeployment -ResourceGroupName $DemoRgName `
    -TemplateFile (Get-Item .\newVm-withCSE.json).FullName `
    -TemplateParameterFile (Get-Item .\newVm-withCSE.parameters.json).FullName

### Example 2

## Deploy the CSE resource on an existing VM - Using one of the VM generated during previous examples
$DemoRgName = "ArmDemo-DomainJoin-RG"

New-AzResourceGroupDeployment -ResourceGroupName $DemoRgName `
    -TemplateFile (Get-Item .\CSE-ReadFile.json).FullName `
    -TemplateParameterFile (Get-Item .\CSE-ReadFile.parameters.json).FullName


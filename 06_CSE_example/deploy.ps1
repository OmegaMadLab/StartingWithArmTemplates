### Example 1

## Deploy a VM which will execute CSE
# $DemoRgName = "AzSatPN-CSE-RG"
#New-AzResourceGroup -Name $DemoRgName -Location "westeurope"

# New-AzResourceGroupDeployment -ResourceGroupName $DemoRgName `
#     -TemplateFile (Get-Item .\newVm-domainJoin.json).FullName `
#     -TemplateParameterFile (Get-Item .\newVm-domainJoin.parameters.json).FullName `
#     -AsJob

### Example 2

## Deploy a DSC resource on an existing VM - Using one of the VM generated during previous examples
$DemoRgName = "AzSatPN-NotJoined-RG"

New-AzResourceGroupDeployment -ResourceGroupName $DemoRgName `
    -TemplateFile (Get-Item .\CSE-ReadFile.json).FullName `
    -TemplateParameterFile (Get-Item .\CSE-ReadFile.parameters.json).FullName


$HelperModulePath = (Get-Item "..\99_HelperScripts\ArmTemplateDemoPsUtilities.psm1").FullName
Import-Module $HelperModulePath

### Storage Account demo
$RgName = "ArmDemo-SimpleTemplate-RG"

$Template = Get-Item -Path ".\storageAccount.json"
$Parameters = Get-Item -Path ".\storageAccount.parameters.json"

# Define RG 
$Rg = Set-AzureRg -Name $RgName

# Invoke deployment
New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile $Template.FullName

# With parameter file
New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile $Template.FullName `
    -TemplateParameterFile $Parameters.FullName

### Demo Cleanup
Remove-AzResourceGroup -Name $RgName `
    -Force `
    -AsJob

### Azure SQL Database demo
$RgName = "ArmDemo-SimpleTemplate-RG"

$Template = Get-Item -Path ".\simpleSQL.json"
$Parameters = Get-Item -Path ".\simpleSQL.parameters.json"

# Define RG 
$Rg = Set-AzureRg -Name $RgName

# Invoke deployment
New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile $Template.FullName

# With parameter file
New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile $Template.FullName `
    -TemplateParameterFile $Parameters.FullName


### Demo Cleanup
Remove-AzResourceGroup -Name $RgName `
    -Force `
    -AsJob

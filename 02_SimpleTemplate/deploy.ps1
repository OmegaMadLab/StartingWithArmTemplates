### Storage Account demo
$Rg = "ArmDemo-SimpleTemplate-RG"

$Template = Get-Item -Path ".\storageAccount.json"
$Parameters = Get-Item -Path ".\storageAccount.parameters.json"

# Define RG 
New-AzResourceGroup -Name $Rg -Location "westeurope"

# Invoke deployment
New-AzResourceGroupDeployment -ResourceGroupName $Rg `
    -TemplateFile $Template.FullName

# With parameter file
New-AzResourceGroupDeployment -ResourceGroupName $Rg `
    -TemplateFile $Template.FullName `
    -TemplateParameterFile $Parameters.FullName

### Azure SQL Database demo
$RgName = "ArmDemo-SimpleTemplate-RG"

$Template = Get-Item -Path ".\simpleSQL.json"
$Parameters = Get-Item -Path ".\simpleSQL.parameters.json"

# Define RG 
$rg = Get-AzResourceGroup -Name $RgName `
        -Location "westeurope" `
        -ErrorAction SilentlyContinue
if(!$rg) {
    New-AzResourceGroup -Name $RgName -Location "westeurope"
}

# Invoke deployment
New-AzResourceGroupDeployment -ResourceGroupName $Rg `
    -TemplateFile $Template.FullName

# With parameter file
New-AzResourceGroupDeployment -ResourceGroupName $RgName `
    -TemplateFile $Template.FullName `
    -TemplateParameterFile $Parameters.FullName

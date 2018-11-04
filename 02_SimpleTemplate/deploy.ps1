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

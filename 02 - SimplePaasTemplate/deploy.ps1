$Rg = "AzureSatPN-SimpleWebAppSqlDB"

$Template = Get-Item -Path ".\WebSiteSqlDatabase.json"
$Parameters = Get-Item -Path ".\WebSiteSqlDatabase.parameters.json"

# Define RG 
New-AzResourceGroup -Name $Rg -Location "westeurope"

# Invoke deployment
New-AzResourceGroupDeployment -ResourceGroupName $RgTest -TemplateFile $Template.FullName -TemplateParameterFile $ParametersTest.FullName

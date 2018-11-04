### Multi-tier template - monolitic approach
$Rg = "ArmDemo-SimpleWebAppSqlDB-monolitic-RG"

$Template = Get-Item -Path ".\WebSiteSqlDatabase_monolitich.json"
$Parameters = Get-Item -Path ".\WebSiteSqlDatabase.parameters.json"

# Define RG 
New-AzResourceGroup -Name $Rg -Location "westeurope"

# Invoke deployment
New-AzResourceGroupDeployment -ResourceGroupName $Rg -TemplateFile $Template.FullName -TemplateParameterFile $Parameters.FullName -AsJob


### Multi-environment template

$RgTest = "ArmDemo-MultiEnv-TEST-RG"
$RgProd = "ArmDemo-MultiEnv-PROD-RG"

$Template = Get-Item -Path ".\differentEnv.json"
$ParametersTest = Get-Item -Path ".\differentEnv.parameters-TEST.json"
$ParametersProd = Get-Item -Path ".\differentEnv.parameters-PROD.json"

# Define RG for test
New-AzResourceGroup -Name $RgTest -Location "westeurope"

# Define RG for prod
New-AzResourceGroup -Name $RgProd -Location "westeurope"

# Invoke test deployment
New-AzResourceGroupDeployment -ResourceGroupName $RgTest `
    -TemplateFile $Template.FullName `
    -TemplateParameterFile $ParametersTest.FullName `
    -AsJob

# Invoke test deployment
New-AzResourceGroupDeployment -ResourceGroupName $RgProd `
    -TemplateFile $Template.FullName `
    -TemplateParameterFile $ParametersProd.FullName `
    -AsJob

# Check status
Get-Job | Receive-Job


### Update existing resources in two steps (contains inline nested template)
$Rg = "ArmDemo-UpdateResource-RG"
New-AzResourceGroup -Name $Rg -Location "westeurope"

$Template = Get-Item -Path ".\updateResource.json"
New-AzResourceGroupDeployment -ResourceGroupName $Rg -TemplateFile $Template.FullName -AsJob
$HelperModulePath = (Get-Item "..\99_HelperScripts\ArmTemplateDemoPsUtilities.psm1").FullName
Import-Module $HelperModulePath

### Multi-tier template - monolithic approach
$RgName = "ArmDemo-SimpleWebAppSqlDB-monolithic-RG"

$Template = Get-Item -Path ".\WebSiteSqlDatabase_monolithic.json"
$Parameters = Get-Item -Path ".\WebSiteSqlDatabase.parameters.json"

# Define RG 
$Rg = Set-AzureRg -Name $RgName

# Invoke deployment
New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile $Template.FullName `
    -TemplateParameterFile $Parameters.FullName `
    -AsJob

### Multi-tier template - linked approach
$RgName = "ArmDemo-SimpleWebAppSqlDB-linked-RG"

$Template = Get-Item -Path ".\WebSiteSqlDatabase_linked.json"
$Parameters = Get-Item -Path ".\WebSiteSqlDatabase.parameters.json"

# Define RG 
$Rg = Set-AzureRg -Name $RgName

# Invoke deployment
New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile $Template.FullName `
    -TemplateParameterFile $Parameters.FullName `
    -AsJob


### Multi-environment template - WebApp

$RgTestName = "ArmDemo-MultiEnv-Web-TEST-RG"
$RgProdName = "ArmDemo-MultiEnv-Web-PROD-RG"

$Template = Get-Item -Path ".\differentEnv.json"
$ParametersTest = Get-Item -Path ".\differentEnv.parameters-TEST.json"
$ParametersProd = Get-Item -Path ".\differentEnv.parameters-PROD.json"

# Define RG for test
$RgTest = Set-AzureRg -Name $RgTestName

# Define RG for prod
$RgProd = Set-AzureAg -Name $RgProdName

# Invoke test deployment
New-AzResourceGroupDeployment -ResourceGroupName $RgTest.ResourceGroupName `
    -TemplateFile $Template.FullName `
    -TemplateParameterFile $ParametersTest.FullName `
    -AsJob

# Invoke prod deployment
New-AzResourceGroupDeployment -ResourceGroupName $RgProd.ResourceGroupName `
    -TemplateFile $Template.FullName `
    -TemplateParameterFile $ParametersProd.FullName `
    -AsJob

### Multi-environment template - SQL

$RgTestName = "ArmDemo-MultiEnv-SQL-TEST-RG"
$RgProdName = "ArmDemo-MultiEnv-SQL-PROD-RG"

$Template = Get-Item -Path ".\sqlDifferentEnv.json"
$ParametersTest = Get-Item -Path ".\sqlDifferentEnv.parameters-TEST.json"
$ParametersProd = Get-Item -Path ".\sqlDifferentEnv.parameters-PROD.json"

# Define RG for test
$RgTest = Set-AzureRg -Name $RgTestName

# Define RG for prod
$RgProd = Set-AzureAg -Name $RgProdName

# Invoke test deployment
New-AzResourceGroupDeployment -ResourceGroupName $RgTest.ResourceGroupName `
    -TemplateFile $Template.FullName `
    -TemplateParameterFile $ParametersTest.FullName `
    -AsJob

# Invoke prod deployment
New-AzResourceGroupDeployment -ResourceGroupName $RgProd.ResourceGroupName `
    -TemplateFile $Template.FullName `
    -TemplateParameterFile $ParametersProd.FullName `
    -AsJob

# Check status
Get-Job | Receive-Job


### Update existing resources in two steps (contains inline nested template)
$RgName = "ArmDemo-UpdateResource-RG"
$Rg = Set-AzureRg -Name $RgName

$Template = Get-Item -Path ".\updateResource.json"
New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile $Template.FullName `
    -AsJob
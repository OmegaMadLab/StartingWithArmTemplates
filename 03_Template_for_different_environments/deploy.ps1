$RgTest = "AzureSatPN-MultiEnv-TEST"
$RgProd = "AzureSatPN-MultiEnv-PROD"

$Template = Get-Item -Path ".\differentEnv.json"
$ParametersTest = Get-Item -Path ".\differentEnv.parameters-TEST.json"
$ParametersProd = Get-Item -Path ".\differentEnv.parameters-PROD.json"

# Define RG for test
New-AzResourceGroup -Name $RgTest -Location "westeurope"

# Define RG for prod
New-AzResourceGroup -Name $RgProd -Location "westeurope"

# Invoke test deployment
New-AzResourceGroupDeployment -ResourceGroupName $RgTest -TemplateFile $Template.FullName -TemplateParameterFile $ParametersTest.FullName -AsJob

# Invoke test deployment
New-AzResourceGroupDeployment -ResourceGroupName $RgProd -TemplateFile $Template.FullName -TemplateParameterFile $ParametersProd.FullName -AsJob

# Check status
Get-Job | Receive-Job
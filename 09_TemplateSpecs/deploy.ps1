# As of October 2020, Template Specs are in preview.
# To use them, you need to onboard your subscription: https://aka.ms/templateSpecOnboarding
# and install the PowerShell module from https://github.com/Azure/template-specs


$HelperModulePath = (Get-Item "..\99_HelperScripts\ArmTemplateDemoPsUtilities.psm1").FullName
Import-Module $HelperModulePath

# Define RG 
$RgName = "ArmDemo-TemplateSpec-RG"
$Rg = Set-AzureRg -Name $RgName


# Create a new template spec for the storageAccount.json template
Remove-Module Az.Resources
Import-Module Az.Resources -RequiredVersion 2.4.2 -Force

New-AzTemplateSpec -Name storageSpec `
    -Version 1.0 `
    -ResourceGroupName $rg.ResourceGroupName `
    -Location westeurope `
    -TemplateFile .\storageAccount.json

# Get Template Spec v1.0
$templateSpec = Get-AzTemplateSpec -ResourceGroupName $rg.ResourceGroupName `
                    -Name storageSpec `
                    -Version 1.0



# Deploy from Template Spec
New-AzResourceGroupDeployment `
  -ResourceGroupName $rg.ResourceGroupName `
  -TemplateSpecId $templateSpec.Versions.id
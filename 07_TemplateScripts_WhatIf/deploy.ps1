$HelperModulePath = (Get-Item "..\99_HelperScripts\ArmTemplateDemoPsUtilities.psm1").FullName
Import-Module $HelperModulePath

##### What-If Example 1
### Storage Account demo
$RgName = "ArmDemo-WhatIf-RG"

$Template = Get-Item -Path ".\storageAccount.json"

# Define RG 
$Rg = Set-AzureRg -Name $RgName

# Test deployment with What-If
# To use the WhatIf switch, use an updated version of the Az module (4.2 or later)
New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile $Template.FullName `
    -storageAccountPrefix "omegamadlab" `
    -Confirm

New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile $Template.FullName `
    -storageAccountPrefix "omegamadlab" `
    -redundancy "Standard_GRS" `
    -WhatIf

### Demo Cleanup
Remove-AzResourceGroup -Name $RgName `
    -Force `
    -AsJob


##### DeploymentScript Example

# Deploy a new Azure SQL Logical Server with AAD Admin by specifying only the admin UPN as parameter
$RgName = "ArmDemo-DeploymentScript-RG"
$Rg = Set-AzureRg -Name $RgName

$adminUpn = Read-Host -Prompt "Insert the SQL Server AAD Admin UserPrincipalName"

# Create a User-Assigned Managed Identity and authorize it to read AAD
Install-Module -Name Az.ManagedServiceIdentity -AllowPrerelease

$msi = New-AzUserAssignedIdentity -Name "DeploymentScriptIdentity" `
        -ResourceGroupName $RgName

# Here I'm using the AzureAD module in PowerShell 7 with backward compatibility.
# The following sintax may raise errors in the VSCode PowerShell Integrated Console - Switch to pwsh 7
Import-Module AzureAD -UseWindowsPowerShell
Connect-AzureAd -TenantId (Get-AzContext).Tenant.Id

$aadSp = Get-AzureADServicePrincipal -Filter "appId eq '00000002-0000-0000-c000-000000000000'"
$DirectoryReadAll = az ad sp show --id $aadSp.ObjectId --query "appRoles[?value=='Directory.Read.All'].id | [0]" -o tsv

New-AzureAdServiceAppRoleAssignment -ObjectId $MSI.PrincipalId `
    -PrincipalId $MSI.PrincipalId `
    -ResourceId $aadSp.ObjectId `
    -Id $DirectoryReadAll

# Assign Contributor RBAC role on the RG to the MSI
$msi = Get-AzUserAssignedIdentity -Name "DeploymentScriptIdentity" `
        -ResourceGroupName $RgName

New-AzRoleAssignment -ObjectId $msi.PrincipalId -RoleDefinitionName "Contributor" -ResourceGroupName $RgName

# Deploy the template
New-AzResourceGroupDeployment -ResourceGroupName $Rg.ResourceGroupName `
    -TemplateFile (Get-Item .\sqlDbWithLogin.json).FullName `
    -sqlAdminUsername "sqladmin" `
    -sqlAdminPassword (ConvertTo-SecureString "Passw0rd.1" -AsPlainText -Force) `
    -aadAdminUpn $adminUpn `
    -userAssignedManagedIdentityId $msi.Id

### Demo Cleanup
Remove-AzResourceGroup -Name $RgName `
    -Force `
    -AsJob


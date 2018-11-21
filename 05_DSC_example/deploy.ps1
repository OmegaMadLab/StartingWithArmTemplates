##### Domain join example

### PREREQ

# Create a new AD forest on a brand new VM
New-AzResourceGroup -Name "ActiveDirectory-RG" -Location "westeurope"

New-AzResourceGroupDeployment -ResourceGroupName "ActiveDirectory-RG" `
    -TemplateUri "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/active-directory-new-domain/azuredeploy.json" `
    -adminUserName "contosoAdmin" `
    -adminPassword $(ConvertTo-SecureString -AsPlainText "Passw0rd1" -Force) `
    -domainName "contoso.local" `
    -dnsPrefix "contosodemodc" `
    -AsJob

### Example 1

# Deploy a VM which will join the domain via template
$DemoRgName = "ArmDemo-DomainJoin-RG"
New-AzResourceGroup -Name $DemoRgName -Location "westeurope"

New-AzResourceGroupDeployment -ResourceGroupName $DemoRgName `
    -TemplateFile (Get-Item .\newVm-domainJoin.json).FullName `
    -TemplateParameterFile (Get-Item .\newVm-domainJoin.parameters.json).FullName `
    -AsJob

### Example 2

# Deploy a VM not joined to the domain
$DemoRgName = "ArmDemo-NotJoined-RG"
New-AzResourceGroup -Name $DemoRgName -Location "westeurope"

New-AzResourceGroupDeployment -ResourceGroupName $DemoRgName `
    -TemplateFile (Get-Item .\newVm-toBeJoined.json).FullName `
    -TemplateParameterFile (Get-Item .\newVm-toBeJoined.parameters.json).FullName

## Deploy a DSC resource on an existing VM
$DemoRgName = "ArmDemo-NotJoined-RG"

New-AzResourceGroupDeployment -ResourceGroupName $DemoRgName `
    -TemplateFile (Get-Item .\DSC-domainJoin.json).FullName `
    -TemplateParameterFile (Get-Item .\DSC-domainJoin.parameters.json).FullName


## Create a new AD forest on a brand new VM
New-AzResourceGroup -Name "ActiveDirectory-RG" -Location "westeurope"

New-AzResourceGroupDeployment -ResourceGroupName "ActiveDirectory-RG" `
    -TemplateUri "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/active-directory-new-domain/azuredeploy.json" `
    -adminUserName "contosoAdmin" `
    -adminPassword $(ConvertTo-SecureString -AsPlainText "Passw0rd1" -Force) `
    -domainName "contoso.local" `
    -dnsPrefix "contosodemodc" `
    -AsJob


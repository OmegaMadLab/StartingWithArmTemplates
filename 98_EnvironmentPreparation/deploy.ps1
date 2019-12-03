$HelperModulePath = (Get-Item "..\99_HelperScripts\ArmTemplateDemoPsUtilities.psm1").FullName
Import-Module $HelperModulePath

Add-AzAccount

$domain = "contoso.local"
$domainAdmin = "contosoadmin"
$domainAdminPwd = (ConvertTo-SecureString "Passw0rd1" -AsPlainText -Force)

#Deploy an Active Directory domain in a dedicated RG
$RgName = "ArmDemo-AD-RG"
$Rg = Set-AzureRg -Name $RgName

# Create an AD forest with 2 DC by using a quickstart gallery template
New-AzResourceGroupDeployment -TemplateUri https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/active-directory-new-domain-ha-2-dc/azuredeploy.json `
    -ResourceGroupName $Rg.ResourceGroupName `
    -domainName $domain `
    -adminUsername $domainAdmin `
    -adminPassword $domainAdminPwd `
    -dnsPrefix ("armdemo-" + (Get-Random -Maximum 99999)) `
    -pdcRDPPort 59990 `
    -bdcRDPPort 59991 `
    -location $Rg.Location

# To reduce lab costs, deallocate VMs created before and reduce their size and tier of disks
$adVm = Get-AzVm -ResourceGroupName $Rg.ResourceGroupName |
            ? Name -like 'ad*'

$adVmJob = $adVm | Stop-AzVm -Force -asJob

While (($adVmJob | Get-Job).State -ne "Completed") {
    Start-Sleep -Seconds 1
}

$adVmIp = @()

$adVm | % { $_.HardwareProfile = "Standard_B2s"}
$adVm | % {
    $diskUpdate = New-AzDiskUpdateConfig -SkuName "StandardSSD_LRS" 
    Update-AzDisk -ResourceGroupName $rg.ResourceGroupName -DiskName $_.StorageProfile.OsDisk.Name -DiskUpdate $diskUpdate
    $_.StorageProfile.DataDisks | % { Update-AzDisk -ResourceGroupName $rg.ResourceGroupName -DiskName $_.Name -DiskUpdate $diskUpdate }
    $adVmIp += ($_.NetworkProfile.NetworkInterfaces[0].Id | Get-AzNetworkInterface).IpConfigurations[0].PrivateIpAddress
}

# Set DNS on vnet
$vnet = Get-AzVirtualNetwork -Name "adVnet" `
            -ResourceGroupName $Rg.ResourceGroupName

$vnet.DhcpOptions.DnsServers = $adVmIp

$vnet | Set-AzVirtualNetwork

$adVm | Update-AzVM
$adVm | Start-AzVm -AsJob



Import-Module Az.Resources
function Set-AzureRg {
    param(
        [Parameter(Mandatory=$true,
                   Position=0,
                   HelpMessage="Name of the resource group.")]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name,

        [Parameter(Mandatory=$false,
                   HelpMessage="Location of the resource group.")]
        [string]
        $Location="westeurope"
    )

    $ResourceGroup = Get-AzResourceGroup -Name $Name `
                        -Location $Location `
                        -ErrorAction SilentlyContinue

    if(!$ResourceGroup) {
        New-AzResourceGroup -Name $RgName -Location "westeurope"
    }

    $ResourceGroup
}

Export-ModuleMember -Function "Set-AzureRg"
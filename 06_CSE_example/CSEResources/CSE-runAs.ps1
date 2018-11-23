[CmdletBinding()]

param (
        # Script to run
        [Parameter(Mandatory = $true)]
        [string]
        $ScriptToRun,

        # Array of script parameters
        [Parameter(Mandatory = $true)]
        [string[]]
        $ScriptParams,
        
        # Username
        [Parameter(Mandatory = $true)]
        [string]
        $Username,

        #Password
        [Parameter(Mandatory = $true)]
        [string]
        $Password
)

$Credential = New-Object System.Management.Automation.PSCredential($Username, ($Password | ConvertTo-SecureString -AsPlainText -Force))

#Execution with different account
Enable-PSRemoting -Force
$DomainName = [System.String] (Get-CimInstance -ClassName Win32_ComputerSystem -Verbose:$false).Domain;

if($DomainName -eq "WORKGROUP") {
    $WsManList = "WSMAN/$env:COMPUTERNAME"
} else {
    $WsManList = "WSMAN/*.$DomainName"
}

Enable-WSManCredSSP -Role Client -DelegateComputer $WsManList -Force
Enable-WSManCredSSP -Role Server -Force

$WorkingPath = (Push-Location -PassThru).Path

Invoke-Command -FilePath ".\$ScriptToRun" `
    -ArgumentList $ScriptParams `
    -Credential $credential `
    -ComputerName $env:COMPUTERNAME `
    -Authentication Credssp

Disable-WSManCredSSP -Role Client
Disable-WSManCredSSP -Role Server
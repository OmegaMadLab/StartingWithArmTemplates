[CmdletBinding()]

param (
        # Script to run
        [Parameter(Mandatory = $true)]
        [string]
        $ScriptToRun,

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
Enable-WSManCredSSP -Role Client -DelegateComputer "*.$DomainName" -Force
Enable-WSManCredSSP -Role Server -Force

Invoke-Command -ScriptBlock { $ScriptToRun }
    -Credential $credential `
    -ComputerName $env:COMPUTERNAME

Disable-WSManCredSSP -Role Client
Disable-WSManCredSSP -Role Server
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
$Arguments = "-file $ScriptToRun"

Start-Process powershell.exe -ArgumentList $arguments -Credential $Credential -NoNewWindow
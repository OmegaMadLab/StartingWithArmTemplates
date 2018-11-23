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
$Args = "-executionPolicy Unrestricted -file $ScriptToRun"

$Args | Out-File .\Degug.txt

Start-Process -Credential $Credential -NoNewWindow -WorkingDirectory .\ -FilePath powershell.exe -ArgumentList $Args 
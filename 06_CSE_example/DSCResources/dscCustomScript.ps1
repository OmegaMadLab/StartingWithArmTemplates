Configuration DscAsCustomScript {

    param (
        [Parameter(Mandatory)]
        [System.Management.Automation.PSCredential]$SysAdminCreds,

        [Parameter(Mandatory)]
        [int]$TcpPort,

        [Parameter(Mandatory)]
        [int]$MaxDop
        
    )

    # Import the module that contains the resources we're using.
    Import-DscResource -ModuleName PsDesiredStateConfiguration

    # The Node statement specifies which targets this configuration will be applied to.
    Node 'localhost' {

        # The script resource block is used to run a custom script with PsDscRunAsCredential
        # Set and Get functions are fake, just to be sure the Set function is executed
        script 'CustomScript'
        {
            PsDscRunAsCredential = $SysAdminCreds
            GetScript =  { return @{result = 'result'} }
            TestScript = { return $false }
            SetScript = {
                
                $logFile = "C:\SqlConfig.log"

                "Looking for NuGet package manager..." | Out-File -FilePath $LogFile 
                $packageProvider = Get-PackageProvider -Name NuGet -ListAvailable -ErrorAction SilentlyContinue
                if(!$packageProvider) {
                    $packageProviderVersion = "0"
                } else {
                    $packageProviderVersion = ($packageProvider).Version.toString().Replace(".","")
                }
                if($packageProviderVersion -lt 285201) {
                    "NuGet version 2.8.5.201 or higher not found. Trying to install it..." | Out-File -FilePath $LogFile -Append
                    try {
                        Install-PackageProvider -Name NuGet -Force -MinimumVersion 2.8.5.201
                        "NuGet package manager installed." | Out-File -FilePath $LogFile -Append
                    }
                    catch {
                        "Error while installing NuGet package manager:" | Out-File -FilePath $LogFile -Append
                        throw $_  | Out-File -FilePath $LogFile -Append
                    }
                }
                else {
                    "NuGet package manager found." | Out-File -FilePath $LogFile -Append
                }

                Register-PSRepository -Default -InstallationPolicy Trusted -ErrorAction SilentlyContinue

                "Looking for DBATools module..." | Out-File -FilePath $LogFile -Append
                if(!(Get-Module -Name dbatools -ListAvailable)) {
                    "DBATools module not found. Trying to install it..." | Out-File -FilePath $LogFile -Append
                    try {
                        Install-Module -Name DBATools -Force -Confirm:$false
                        "DBATools module installed." | Out-File -FilePath $LogFile -Append
                    }
                    catch {
                        "Error while installing DBATools module:" | Out-File -FilePath $LogFile -Append
                        throw $_  | Out-File -FilePath $LogFile -Append
                    }
                } 
                else {
                    "DBATools module found." | Out-File -FilePath $LogFile -Append
                }

                Set-DbaTcpPort -SqlInstance $ENV:COMPUTERNAME `
                    -Port $($using:TcpPort) `
                    -Confirm:$false |
                    Out-File -FilePath $LogFile -Append

                Set-DbaMaxDop -SqlInstance $ENV:COMPUTERNAME `
                    -MaxDop $($using:MaxDop) |
                    Out-File -FilePath $LogFile -Append
            }
        }

    }
}
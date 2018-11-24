configuration CredSspConfig
{
    param
    (
        [String]$DomainName="WORKGROUP"

    )

    if($DomainName -eq "WORKGROUP") {
        $WsManList = "WSMAN/*"
    } else {
        $WsManList = "WSMAN/*.$DomainName"
    }
    
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node localhost
    {
        Registry CredSSP1 {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation"
            ValueName = "AllowFreshCredentials"
            ValueData = "1"
            ValueType = "Dword"
        }

        Registry CredSSP2 {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation"
            ValueName = "AllowFreshCredentialsWhenNTLMOnly"
            ValueData = "1"
            ValueType = "Dword"
        }

        Registry CredSSP3 {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation\AllowFreshCredentials"
            ValueName = "1"
            ValueData = $WsManList
            ValueType = "String"
            DependsOn = "[Registry]CredSSP1"
        }

        Registry CredSSP4 {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation\AllowFreshCredentialsWhenNTLMOnly"
            ValueName = "1"
            ValueData = $WsManList
            ValueType = "String"
            DependsOn = "[Registry]CredSSP2"
        }

        Script Reboot
        {
            TestScript = {
                return (Test-Path HKLM:\SOFTWARE\MyMainKey\RebootKey)
            }
            SetScript = {
                New-Item -Path HKLM:\SOFTWARE\MyMainKey\RebootKey -Force
                 $global:DSCMachineStatus = 1 
    
            }
            GetScript = { return @{result = 'result'}}
            DependsOn = @('[Registry]CredSSP3', '[Registry]CredSSP4')
        }

        LocalConfigurationManager 
        {
            RebootNodeIfNeeded = $true
        }

    }
}

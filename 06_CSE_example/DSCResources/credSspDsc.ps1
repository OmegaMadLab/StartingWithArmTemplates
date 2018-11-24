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

        Registry RebootKey {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\TestReboot\NeedReboot"
            ValueName = "default"
            ValueData = ""
            ValueType = "String"
            DependsOn = @('[Registry]CredSSP3', '[Registry]CredSSP4')
        }

        Script Reboot
        {
            TestScript = {
                $result = (Invoke-Expression -Command $GetScript)["Result"];
                if($result)
                {
                    return $true;
                }     
                return $false;
            }
            SetScript = {
                Remove-Item -Path HKLM:\SOFTWARE\TestReboot\NeedReboot -Force
                $global:DSCMachineStatus = 1
            }
            GetScript = { return @{result = (!(Test-Path HKLM:\SOFTWARE\TestReboot\NeedReboot))} }
            DependsOn = @('[Registry]RebootKey')
        }

        LocalConfigurationManager 
        {
            RebootNodeIfNeeded = $true
        }

    }
}

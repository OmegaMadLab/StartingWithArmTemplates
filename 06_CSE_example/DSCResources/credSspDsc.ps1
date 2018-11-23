configuration CredSspConfig
{
    param
    (
        [String]$DomainName=$ENV:COMPUTERNAME,

        [String]$DomainNetbiosName=(Get-NetBIOSName -DomainName $DomainName)

    )

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
            ValueData = "WSMAN/*.$DomainName"
            ValueType = "String"
            DependsOn = "[Registry]CredSSP1"
        }

        Registry CredSSP4 {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation\AllowFreshCredentialsWhenNTLMOnly"
            ValueName = "1"
            ValueData = "WSMAN/*.$DomainName"
            ValueType = "String"
            DependsOn = "[Registry]CredSSP2"
        }

        LocalConfigurationManager 
        {
            RebootNodeIfNeeded = $true
        }

    }
}
function Get-NetBIOSName
{ 
    [OutputType([string])]
    param(
        [string]$DomainName
    )

    if ($DomainName.Contains('.')) {
        $length=$DomainName.IndexOf('.')
        if ( $length -ge 16) {
            $length=15
        }
        return $DomainName.Substring(0,$length)
    }
    else {
        if ($DomainName.Length -gt 15) {
            return $DomainName.Substring(0,15)
        }
        else {
            return $DomainName
        }
    }
}

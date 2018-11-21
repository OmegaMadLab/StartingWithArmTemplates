Configuration SqlServerConfig {

    # Get login credentials as parameter
    param (
        [Parameter(Mandatory)]
        [System.Management.Automation.PSCredential]$SysAdminCreds,

        [Parameter(Mandatory)]
        [System.Management.Automation.PSCredential]$NewLoginCreds
    )

    # Import the module that contains the resources we're using.
    Import-DscResource -ModuleName PsDesiredStateConfiguration, SqlServerDsc

    # The Node statement specifies which targets this configuration will be applied to.
    Node 'localhost' {

        # The first resource block create a new SQL Login.
        SqlServerLogin NewSqlLogin {
            Ensure = 'Present'
            Name = $NewLoginCreds.UserName
            LoginType = 'SqlLogin'
            LoginMustChangePassword        = $false
            LoginPasswordExpirationEnabled = $false
            LoginPasswordPolicyEnforced    = $false
            LoginCredential = $NewLoginCreds
            ServerName           = $env:COMPUTERNAME
            InstanceName         = 'MSSQLSERVER'
            PsDscRunAsCredential = $SysAdminCreds
        }

        # The second resource block depends on the new sql login, and assign sysadmin permission to it.
        SqlServerRole Add_ServerRole_SysAdmin
        {
            Ensure               = 'Present'
            ServerRoleName       = 'sysadmin'
            MembersToInclude     = $NewLoginCreds.UserName
            ServerName           = $env:COMPUTERNAME
            InstanceName         = 'MSSQLSERVER'
            PsDscRunAsCredential = $SqlAdministratorCredential
            DependsOn = "[SqlServerLogin]NewSqlLogin"
        }

        # The third resource block has no dependencies, and sets MaxDOP = 1
        SqlServerMaxDop Set_SQLServerMaxDop_ToOne
        {
            Ensure               = 'Present'
            DynamicAlloc         = $false
            MaxDop               = 1
            ServerName           = $env:COMPUTERNAME
            InstanceName         = 'MSSQLSERVER'
            PsDscRunAsCredential = $SysAdminCreds
        }

    }
}
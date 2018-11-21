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

        # The first resource block change TCP port on default instance.
        {
            SqlServerNetwork 'ChangeTcpIpOnDefaultInstance'
            {
                InstanceName         = 'MSSQLSERVER'
                ProtocolName         = 'Tcp'
                IsEnabled            = $true
                TCPDynamicPort       = $false
                TCPPort              = 2666
                RestartService       = $true
                PsDscRunAsCredential = $SystemAdministratorAccount
            }
        }

        # The second resource block depends on first, and sets MaxDOP = 1
        SqlServerMaxDop Set_SQLServerMaxDop_ToOne
        {
            Ensure               = 'Present'
            DynamicAlloc         = $false
            MaxDop               = 1
            InstanceName         = 'MSSQLSERVER'
            PsDscRunAsCredential = $SysAdminCreds
            DependsOn            = "[SqlServerNetwork]ChangeTcpIpOnDefaultInstance"  
        }

    }
}
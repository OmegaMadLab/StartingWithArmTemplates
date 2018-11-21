Configuration SqlServerConfig {

    param (
        [Parameter(Mandatory)]
        [System.Management.Automation.PSCredential]$SysAdminCreds,

        [Parameter(Mandatory)]
        [int]$TcpPort,

        [Parameter(Mandatory)]
        [int]$MaxDop
        
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
                TCPPort              = $TcpPort
                RestartService       = $true
                PsDscRunAsCredential = $SystemAdministratorAccount
            }
        }

        # The second resource block depends on first, and sets MaxDOP
        SqlServerMaxDop Set_SQLServerMaxDop_ToOne
        {
            Ensure               = 'Present'
            DynamicAlloc         = $false
            MaxDop               = $MaxDop
            InstanceName         = 'MSSQLSERVER'
            PsDscRunAsCredential = $SysAdminCreds
            DependsOn            = "[SqlServerNetwork]ChangeTcpIpOnDefaultInstance"  
        }

    }
}
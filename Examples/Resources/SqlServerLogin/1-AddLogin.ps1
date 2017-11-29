<#
.EXAMPLE
This example shows how to ensure that the Windows user 'CONTOSO\WindowsUser' exists.

.EXAMPLE
This example shows how to ensure that the Windows group 'CONTOSO\WindowsGroup' exists.

.EXAMPLE
This example shows how to ensure that the SQL Login 'SqlLogin' exists.
#>

Configuration Example
{
    param(
        [Parameter(Mandatory = $true)]
        [PSCredential]
        $SysAdminAccount,

        [Parameter(Mandatory = $true)]
        [PSCredential]
        $LoginCredential
    )

    Import-DscResource -ModuleName SqlServerDsc

    node localhost {
        SqlServerLogin Add_WindowsUser
        {
            Ensure               = 'Present'
            Name                 = 'CONTOSO\WindowsUser'
            LoginType            = 'WindowsUser'
            SQLServer            = 'SQLServer'
            SQLInstanceName      = 'DSC'
            PsDscRunAsCredential = $SysAdminAccount
        }

        SqlServerLogin Add_DisabledWindowsUser
        {
            Ensure               = 'Present'
            Name                 = 'CONTOSO\WindowsUser2'
            LoginType            = 'WindowsUser'
            SQLServer            = 'SQLServer'
            SQLInstanceName      = 'DSC'
            PsDscRunAsCredential = $SysAdminAccount
            Disabled             = $true
        }

        SqlServerLogin Add_WindowsGroup
        {
            Ensure               = 'Present'
            Name                 = 'CONTOSO\WindowsGroup'
            LoginType            = 'WindowsGroup'
            SQLServer            = 'SQLServer'
            SQLInstanceName      = 'DSC'
            PsDscRunAsCredential = $SysAdminAccount
        }

        SqlServerLogin Add_SqlLogin
        {
            Ensure                         = 'Present'
            Name                           = 'SqlLogin'
            LoginType                      = 'SqlLogin'
            SQLServer                      = 'SQLServer'
            SQLInstanceName                = 'DSC'
            LoginCredential                = $LoginCredential
            LoginMustChangePassword        = $false
            LoginPasswordExpirationEnabled = $true
            LoginPasswordPolicyEnforced    = $true
            PsDscRunAsCredential           = $SysAdminAccount
        }
    }
}
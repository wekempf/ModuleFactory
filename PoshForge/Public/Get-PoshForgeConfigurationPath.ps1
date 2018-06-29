function Get-PoshForgeConfigurationPath {
    [CmdletBinding()]
    param (
        [ValidateSet("User", "Machine", "Enterprise")]
        [string]$Scope = "User"
    )

    begin {
    }

    process {
        Get-ConfigurationPath -Scope $Scope
    }

    end {
    }
}
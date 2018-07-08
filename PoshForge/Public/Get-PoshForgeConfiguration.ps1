function Get-PoshForgeConfiguration {
    [CmdletBinding()]
    [OutputType([Hashtable])]
    param (

    )

    begin {
    }

    process {
        Import-Configuration
    }

    end {
    }
}
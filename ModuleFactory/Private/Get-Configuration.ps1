function Get-Configuration {
    [CmdletBinding()]
    param (

    )

    begin {
    }

    process {
        if (Test-Path ~\.modulefactory\config.psd1) {
            Import-PowerShellDataFile ~\.modulefactory\config.psd1
        } else {
            @{}
        }
    }

    end {
    }
}
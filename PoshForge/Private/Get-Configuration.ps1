function Get-Configuration {
    [CmdletBinding()]
    param (

    )

    begin {
    }

    process {
        if (Test-Path ~\.poshforge\config.psd1) {
            Import-PowerShellDataFile ~\.poshforge\config.psd1
        }
        else {
            @{}
        }
    }

    end {
    }
}
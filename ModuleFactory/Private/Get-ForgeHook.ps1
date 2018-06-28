function Get-ForgeHook {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $false)]
        [string]$Name = '*',

        [switch]$All
    )

    begin {
    }

    process {
        if ($All) {
            if (Test-Path '~\.modulefactory\hooks') {
                Get-Item "~\.modulefactory\hooks\$Name.ps1" -ErrorAction SilentlyContinue | Where-Object { -not $_.PSIsContainer }
            }
            Get-Item "$ModuleRoot\hooks\$Name.ps1" -ErrorAction SilentlyContinue | Where-Object { -not $_.PSIsContainer }
        }
        else {
            Get-ForgeHook $Name -All | Select-Object -First 1
        }
    }

    end {
    }
}
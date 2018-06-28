function Get-ForgeTemplate {
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
            if (Test-Path '~\.poshforge\templates') {
                Get-Item "~\.poshforge\templates\$Name" -ErrorAction SilentlyContinue | Where-Object { $_.PSIsContainer }
            }
            Get-Item "$ModuleRoot\templates\$Name" -ErrorAction SilentlyContinue | Where-Object { $_.PSIsContainer }
        }
        else {
            Get-ForgeTemplate $Name -All | Select-Object -First 1
        }
    }

    end {
    }
}
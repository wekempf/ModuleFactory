function Get-ModuleTemplate {
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
            if (Test-Path '~\.modulefactory\templates') {
                Get-Item "~\.modulefactory\templates\$Name" -ErrorAction SilentlyContinue | Where-Object { $_.PSIsContainer }
            }
            Get-Item "$ModuleRoot\templates\$Name" -ErrorAction SilentlyContinue | Where-Object { $_.PSIsContainer }
        }
        else {
            Get-ModuleTemplate $Name -All | Select-Object -First 1
        }
    }

    end {
    }
}
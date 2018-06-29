function Get-PoshForgeHook {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $false)]
        [string]$Name = '*',

        [switch]$All
    )

    begin {
        $hooksPaths = @(
            'User','Enterprise','Machine' | ForEach-Object {
                Join-Path (Get-PoshForgeConfigurationPath -Scope $_) 'hooks'
            }
            Join-Path $ModuleRoot 'hooks'
        )
    }

    process {
        if ($All) {
            $hooksPaths | ForEach-Object {
                $path = Join-Path $_ "$Name.ps1"
                Get-Item $path -ErrorAction SilentlyContinue | Where-Object { -not $_.PSIsContainer }
            }
        }
        else {
            Get-PoshForgeHook $Name -All | Select-Object -First 1
        }
    }

    end {
    }
}
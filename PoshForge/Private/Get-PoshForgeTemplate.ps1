function Get-PoshForgeTemplate {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $false)]
        [string]$Name = '*',

        [switch]$All
    )

    begin {
        $templatePaths = @(
            'User','Enterprise','Machine' | ForEach-Object {
                Join-Path (Get-PoshForgeConfigurationPath -Scope $_) 'templates'
            }
            Join-Path $ModuleRoot 'templates'
        )
    }

    process {
        if ($All) {
            $templatePaths | ForEach-Object {
                $path = Join-Path $_ $Name
                Get-Item $path -ErrorAction SilentlyContinue | Where-Object { $_.PSIsContainer }
            }
        }
        else {
            Get-PoshForgeTemplate $Name -All | Select-Object -First 1
        }
    }

    end {
    }
}
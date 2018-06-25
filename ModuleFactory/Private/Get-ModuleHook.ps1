function Get-ModuleHook {
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
            Get-ChildItem "~/.modulefactory/hooks/*","$ModuleRoot/hooks/*" -Directory
        }
        else {
            Get-ModuleHook $Name | Select-Object -First 1
        }
    }

    end {
    }
}
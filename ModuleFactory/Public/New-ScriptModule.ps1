function New-ScriptModule {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [string]$Path,

        [Parameter(Position = 1, Mandatory = $true)]
        [string]$Description,

        [Parameter(Mandatory = $false)]
        [string]$Author,

        [Parameter(Mandatory = $false)]
        [Version]$Version = '1.0'
    )

    begin {
        $Path = Get-FullPath $Path
        $moduleName = Split-Path -Leaf $Path
    }

    process {
        $params = @{
            'ModuleName'        = $moduleName
            'ModuleDescription' = $Description
            'ModuleAuthor'      = $Author
            'ModuleVersion'     = $Version
        }
        Invoke-ForgeTemplate ScriptModule $Path $params
    }

    end {
    }
}
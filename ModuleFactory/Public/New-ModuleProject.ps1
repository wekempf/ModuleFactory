function New-ModuleProject {
    [CmdletBinding()]
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
        $template = Get-ModuleTemplate ModuleProject
        $moduleName = Split-Path -Leaf $Path
    }

    process {
        $params = @{
            'TemplatePath'      = $template
            'DestinationPath'   = $Path
            'ModuleName'        = $moduleName
            'ModuleDescription' = $Description
            'ModuleAuthor'      = $Author
            'ModuleVersion'     = $Version
        }
        Invoke-Plaster @params
    }

    end {
    }
}
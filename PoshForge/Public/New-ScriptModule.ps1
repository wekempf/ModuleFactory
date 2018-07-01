function New-ScriptModule {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [string]$DestinationPath,

        [Parameter(Position = 1, Mandatory = $true)]
        [string]$Description,

        [Parameter(Mandatory = $false)]
        [string]$Author,

        [Parameter(Mandatory = $false)]
        [Version]$Version = '1.0'
    )

    begin {
        if (-not $PSBoundParameters.ContainsKey('Confirm')) {
            $ConfirmPreference = $PSCmdlet.SessionState.PSVariable.GetValue('ConfirmPreference')
        }
        if (-not $PSBoundParameters.ContainsKey('WhatIf')) {
            $WhatIfPreference = $PSCmdlet.SessionState.PSVariable.GetValue('WhatIfPreference')
        }
        if (-not $PSBoundParameters.ContainsKey('Verbose')) {
            $VerbosePreference = $PSCmdlet.SessionState.PSVariable.GetValue('VerbosePreference')
        }
        $config = Get-PoshForgeConfiguration
        $DestinationPath = Get-FullPath $DestinationPath
        $moduleName = Split-Path -Leaf $DestinationPath
        if (-not ($PSBoundParameters.ContainsKey('Author'))) {
            if ($config.ContainsKey('Author')) {
                $Author = $config['Author']
            }
        }
        if (-not ($PSBoundParameters.ContainsKey('Version'))) {
            if ($config.ContainsKey('Version')) {
                $Version = $config['Version']
            }
        }
    }

    process {
        if ($Force -or $PSCmdlet.ShouldProcess("$moduleName", "Writing template files to $(Split-Path $DestinationPath)")) {
            $params = @{
                'ModuleName'        = $moduleName
                'ModuleDescription' = $Description
                'ModuleAuthor'      = $Author
                'ModuleVersion'     = $Version
            }
            Invoke-ForgeTemplate ScriptModule $DestinationPath $params
        }
    }

    end {
    }
}
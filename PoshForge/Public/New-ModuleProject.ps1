<#
.Synopsis
    Scaffolds out a new module project.
.Description
    Scaffolds out a new module project complete with a build script, documentation support, custom type formating, dependency management and unit tests.
.Parameter DestinationPath
    Specifies the path to a directory to place the module project files.
.Parameter Description
    Specifies the description of the module to be created.
.Parameter Author
    Specifies the module author.

    If you omit this parameter, New-ModuleProject will first try to use the Author key specified in the configuration (see about_PoshForge_Configuration) or the name of the current user.
.Parameter Version
    Specifies the version of the module.

    This parameter is not required by the cmdlet. If you omit this parameter, New-ModuleProject creates a ModuleVersion key with either the ModuleVersion key specified in the configuration (see about_PoshForge_Configuration) or a value of "1.0".
.Parameter Force
    Forces this cmdlet to override the confirmation prompt and allow the cmdlet to overwrite existing files.
.Link
    about_PoshForge_Configuration
#>
function New-ModuleProject {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    [OutputType([System.IO.DirectoryInfo])]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [string]$DestinationPath,

        [Parameter(Position = 1, Mandatory = $true)]
        [string]$Description,

        [Parameter(Mandatory = $false)]
        [string]$Author,

        [Parameter(Mandatory = $false)]
        [Version]$Version,

        [Switch]$Force
    )
    DynamicParam {
        $vcsSet = @(Get-PoshForgeTemplate -Name 'Vcs*' | Select-Object -Unique | ForEach-Object {
                $_.Name.Substring(3)
            })
        New-DynamicParameter 'VersionControl' 'string[]' -ValidateSet $vcsSet -HelpMessage 'Specifies the version control system to use.'
    }

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
            Invoke-ForgeTemplate ModuleProject $DestinationPath $params -Force | Out-Null
            Invoke-ForgeTemplate ScriptModule (Join-Path $DestinationPath $moduleName) $params -Force | Out-Null
            if ($PSBoundParameters.ContainsKey('VersionControl')) {
                $versionControl = $PSBoundParameters.VersionControl
            }
            elseif ($config.ContainsKey('VersionControl')) {
                $versionControl = $config.VersionControl
            }
            if ($versionControl) {
                Invoke-ForgeTemplate "Vcs$versionControl" $DestinationPath -Force | Out-Null
            }
            Get-Item $DestinationPath
        }
    }

    end {
    }
}
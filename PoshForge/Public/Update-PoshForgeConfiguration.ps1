function Update-PoshForgeConfiguration {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param (
        [Parameter(Position = 0, Mandatory = $True)]
        [string]$PropertyName,

        [Parameter(Position = 1, Mandatory = $True)]
        [string]$Value,

        [ValidateSet("User", "Machine", "Enterprise")]
        [string]$Scope = "User",

        [switch]$Force
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
    }

    process {
        $configPath = Get-PoshForgeConfigurationPath -Scope $Scope
        $configFile = Join-Path $configPath 'Configuration.psd1'
        if ($Force -or $PSCmdlet.ShouldProcess("Update-PoshForgeConfiguration", "Updating configuration at '$configFile'.")) {
            if (Test-Path $configFile) {
                $config = Import-Metadata -Path $configFile
            }
            else {
                $config = @{ }
            }
            $config[$PropertyName] = $Value
            New-Item $configPath -ItemType Directory -Force | Out-Null
            Export-Metadata -Path $configFile -InputObject $config
        }
    }

    end {
    }
}
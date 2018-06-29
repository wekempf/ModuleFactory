function Update-PoshForgeConfiguration {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $True)]
        [string]$PropertyName,

        [Parameter(Position = 1, Mandatory = $True)]
        [string]$Value,

        [ValidateSet("User", "Machine", "Enterprise")]
        [string]$Scope = "User"
    )

    begin {
    }

    process {
        $configFile = Join-Path (Get-PoshForgeConfigurationPath -Scope $Scope) 'Configuration.psd1'
        if (Test-Path $configFile) {
            $config = Import-Metadata -Path $configFile
        }
        else {
            $config = @{ }
        }
        $config[$PropertyName] = $Value
        Export-Metadata -Path $configFile -InputObject $config
    }

    end {
    }
}
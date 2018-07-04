$poshForge = "$PSScriptRoot\..\output\PoshForge\PoshForge.psd1"
Import-Module $poshForge -Force

Describe 'Get-PoshForgeConfigurationPath' {
    # Quiet output from Plaster
    Mock -ModuleName Plaster -CommandName Write-Warning {}
    Mock -ModuleName Plaster -CommandName Write-Host {}

    Context 'Getting machine configuration path' {
        $configPath = Get-PoshForgeConfigurationPath -Scope Machine

        It 'Should get the configuration path' {
            $configPath | Should not be $null
        }
    }
    Context 'Getting enterprise configuration path' {
        $configPath = Get-PoshForgeConfigurationPath -Scope Enterprise

        It 'Should get the configuration path' {
            $configPath | Should not be $null
        }
    }
    Context 'Getting user configuration path' {
        $configPath = Get-PoshForgeConfigurationPath -Scope User

        It 'Should get the configuration path' {
            $configPath | Should not be $null
        }
    }
}
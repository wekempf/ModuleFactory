$poshForge = "$PSScriptRoot\..\output\PoshForge\PoshForge.psd1"
Import-Module $poshForge -Force

Describe 'Get-PoshForgeConfiguration' {
    Context 'Getting configuration values' {
        $config = Get-PoshForgeConfiguration

        It 'Should get the configuratoin values' {
            $config | Should not be $null
        }
    }
}
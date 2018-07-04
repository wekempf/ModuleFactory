$poshForge = "$PSScriptRoot\..\output\PoshForge\PoshForge.psd1"
Import-Module $poshForge -Force

Describe 'Update-PoshForgeConfiguration' {
    # Mock configuration cmdlets to use TestDrive based configuration paths
    . "$PSScriptRoot\MockConfiguration.ps1"

    Context 'Update configuration' {
        New-Item TestDrive:\User -ItemType Container | Out-Null
        Update-PoshForgeConfiguration -PropertyName Author -Value 'Jack Ryan'
        It 'Should set property' {
            $config = Import-Metadata TestDrive:\User\Configuration.psd1
            $config.Author | Should be 'Jack Ryan'
        }
    }
    Context 'Update configuration twice' {
        New-Item TestDrive:\User -ItemType Container | Out-Null
        Update-PoshForgeConfiguration -PropertyName Author -Value 'Jack Ryan'
        Update-PoshForgeConfiguration -PropertyName Version -Value 8.0
        It 'Should set properties' {
            $config = Import-Metadata TestDrive:\User\Configuration.psd1
            $config.Author | Should be 'Jack Ryan'
            $config.Version | Should be '8.0'
        }
    }
}
$poshForge = "$PSScriptRoot\..\output\PoshForge\PoshForge.psd1"
Import-Module $poshForge -Force

Describe 'New-ScriptModule' {
    # Quiet output from Plaster
    Mock -ModuleName Plaster -CommandName Write-Host {}

    # Mock configuration cmdlets to use TestDrive based configuration paths
    . "$PSScriptRoot\MockConfiguration.ps1"

    Context 'Scaffolding a simple module' {
        Push-Location TestDrive:\
        try {
            New-ScriptModule -DestinationPath MyModule -Description 'A simple module'
        }
        finally {
            Pop-Location
        }
        It 'Should create module directory' {
            Test-Path TestDrive:\MyModule -PathType Container | Should be $true
        }
        It 'Should create module metadata' {
            Test-Path TestDrive:\MyModule\MyModule.psd1 -PathType Leaf | Should be $true
        }
        It 'Should create module script' {
            Test-Path TestDrive:\MyModule\MyModule.psm1 -PathType Leaf | Should be $true
        }
        It 'Should create public function directory' {
            Test-Path TestDrive:\MyModule\public -PathType Container | Should be $true
        }
        It 'Should create private function directory' {
            Test-Path TestDrive:\MyModule\private -PathType Container | Should be $true
        }
        It 'Should create classes directory' {
            Test-Path TestDrive:\MyModule\classes -PathType Container | Should be $true
        }
    }
    Context 'Module manifest should contain specified values' {
        Push-Location TestDrive:\
        try {
            New-ScriptModule -DestinationPath MyModule -Description 'A simple module' -Author 'John Doe' -Version 2.0
            $metadata = Import-PowerShellDataFile TestDrive:\MyModule\MyModule.psd1
        }
        finally {
            Pop-Location
        }
        It 'Should have specified Description' {
            $metadata.Description | Should be 'A simple module'
        }
        It 'Should have specified Author' {
            $metadata.Author | Should be 'John Doe'
        }
        It 'Should have specified ModuleVersion' {
            $metadata.ModuleVersion | Should be '2.0'
        }
        It 'Should have specified RootModule' {
            $metadata.RootModule | Should be 'MyModule.psm1'
        }
    }
    Context 'Module scaffolding should use configuration values when not specified' {
        Push-Location TestDrive:\
        try {
            $config = @{
                Author  = 'Jane Doe'
                Version = '7.0'
            }
            New-Item TestDrive:\User -ItemType Directory -Force | Out-Null
            Export-Metadata -Path TestDrive:\User\Configuration.psd1 -InputObject $config
            New-ScriptModule -DestinationPath MyModule -Description 'A simple module'
            $metadata = Import-PowerShellDataFile TestDrive:\MyModule\MyModule.psd1
        }
        finally {
            Pop-Location
        }
        It 'Should have specified Author' {
            $metadata.Author | Should be 'Jane Doe'
        }
        It 'Should have specified ModuleVersion' {
            $metadata.ModuleVersion | Should be '7.0'
        }
    }
}

$poshForge = "$PSScriptRoot\..\output\PoshForge\PoshForge.psd1"
Import-Module $poshForge -Force

Describe 'Get-ModuleProjectRoot' {
    # Quiet output from Plaster
    Mock -ModuleName Plaster -CommandName Write-Host {}

    New-ModuleProject -DestinationPath TestDrive:\MyModule -Description "My simple module."
    $expected = 'TestDrive:\MyModule'

    Context 'Should return root when in root' {
        Push-Location TestDrive:\MyModule
        try {
            $root = Get-ModuleProjectRoot
        }
        finally {
            Pop-Location
        }
        Resolve-Path $root | Should Be $expected
    }
    Context 'Should return root when in subdirectory' {
        Push-Location TestDrive:\MyModule\MyModule\public
        try {
            $root = Get-ModuleProjectRoot
        }
        finally {
            Pop-Location
        }
        Resolve-Path $root | Should Be $expected
    }
}
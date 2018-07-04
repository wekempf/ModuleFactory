$poshForge = "$PSScriptRoot\..\output\PoshForge\PoshForge.psd1"
Import-Module $poshForge -Force

Describe 'New-ModuleProject' {
    # Quiet output from Plaster
    Mock -ModuleName Plaster -CommandName Write-Host {}

    # Mock configuration cmdlets to use TestDrive based configuration paths
    . "$PSScriptRoot\MockConfiguration.ps1"

    Context 'Scaffolding a simple module project' {
        Push-Location TestDrive:\
        try {
            New-ModuleProject -DestinationPath MyModule -Description 'A simple module'
        }
        finally {
            Pop-Location
        }
        It 'Should create module project directory' {
            Test-Path TestDrive:\MyModule -PathType Container | Should be $true
        }
        It 'Should create module directory' {
            Test-Path TestDrive:\MyModule\MyModule -PathType Container | Should be $true
        }
        It 'Should create module metadata' {
            Test-Path TestDrive:\MyModule\MyModule\MyModule.psd1 -PathType Leaf | Should be $true
        }
        It 'Should create module script' {
            Test-Path TestDrive:\MyModule\MyModule\MyModule.psm1 -PathType Leaf | Should be $true
        }
        It 'Should create public function directory' {
            Test-Path TestDrive:\MyModule\MyModule\public -PathType Container | Should be $true
        }
        It 'Should create private function directory' {
            Test-Path TestDrive:\MyModule\MyModule\private -PathType Container | Should be $true
        }
        It 'Should create classes directory' {
            Test-Path TestDrive:\MyModule\MyModule\classes -PathType Container | Should be $true
        }
    }
    Context 'Scaffolding with Git as VersionControl parameter' {
        Push-Location TestDrive:\
        try {
            New-ModuleProject -DestinationPath MyModule -Description 'A simple module' -VersionControl Git
        }
        finally {
            Pop-Location
        }
        It 'Should initialize Git repository' {
            Test-Path TestDrive:\MyModule\.git -PathType Container | Should be $true
        }
        It 'Should create a .gitignore file' {
            Test-Path TestDrive:\MyModule\.gitignore -PathType Leaf | Should be $true
        }
    }
    Context 'Scaffolding with Git as VersionControl configuration value' {
        Push-Location TestDrive:\
        try {
            $config = @{
                VersionControl = 'Git'
            }
            New-Item TestDrive:\User -ItemType Directory -Force | Out-Null
            Export-Metadata -Path TestDrive:\User\Configuration.psd1 -InputObject $config
            New-ModuleProject -DestinationPath MyModule -Description 'A simple module'
        }
        finally {
            Pop-Location
        }
        It 'Should initialize Git repository' {
            Test-Path TestDrive:\MyModule\.git -PathType Container | Should be $true
        }
    }
}

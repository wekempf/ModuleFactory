$poshForge = "$PSScriptRoot\..\output\PoshForge\PoshForge.psd1"
Import-Module $poshForge -Force

Describe 'Get-ScriptModuleRoot' {
    # Quiet output from Plaster
    Mock -ModuleName Plaster -CommandName Write-Host {}

    New-ModuleProject -DestinationPath TestDrive:\MyModule -Description "My simple module."
    New-Item TestDrive:\MyModule\docs -ItemType Container | Out-Null
    $expected = 'TestDrive:\MyModule\MyModule'

    Context 'In module root' {
        Push-Location TestDrive:\MyModule\MyModule
        try {
            $root = Get-ScriptModuleRoot
        }
        finally {
            Pop-Location
        }
        It 'Should return module root' {
            $root | Should Be $expected
        }
    }
    Context 'In module subdirectory' {
        Push-Location TestDrive:\MyModule\MyModule\public
        try {
            $root = Get-ScriptModuleRoot
        }
        finally {
            Pop-Location
        }
        It 'Should return module root' {
            $root | Should Be $expected
        }
    }
    Context 'Should return root when in project root' {
        Push-Location TestDrive:\MyModule
        try {
            $root = Get-ScriptModuleRoot
        }
        finally {
            Pop-Location
        }
        $root | Should Be $expected
    }
    Context 'Should return root when in project subdirectory' {
        Push-Location TestDrive:\MyModule\docs
        try {
            $root = Get-ScriptModuleRoot
        }
        finally {
            Pop-Location
        }
        $root | Should Be $expected
    }
}
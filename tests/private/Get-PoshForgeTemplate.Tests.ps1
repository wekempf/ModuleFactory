& $PSScriptRoot\..\ImportModule.ps1

InModuleScope PoshForge {
    Describe "Get-PoshForgeTemplate" {
        BeforeEach {
            & $PSScriptRoot\..\BackupConfig.ps1
        }
        AfterEach {
            & $PSScriptRoot\..\RestoreConfig.ps1
        }
        Context "Template only in module templates" {
            It "Should return path" {
                $moduleDir = Split-Path (Get-Module PoshForge).Path
                $expected = Get-Item (Join-Path $moduleDir 'templates\ModuleProject')

                $result = Get-PoshForgeTemplate -Name ModuleProject

                $result.FullName | Should be $expected.FullName
            }
        }
        Context "Template in local templates" {
            It "Should return path" {
                $configDir = Get-PoshForgeConfigurationPath
                $expected = New-Item -Path (Join-Path $configDir 'templates\ModuleProject') -ItemType Directory -Force

                $result = Get-PoshForgeTemplate -Name ModuleProject

                $result.FullName | Should be $expected.FullName
            }
        }
    }
}
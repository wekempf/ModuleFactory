& $PSScriptRoot\ImportModule.ps1

Describe "New-ModuleProject" {
    BeforeEach {
        & $PSScriptRoot\BackupConfig.ps1
    }
    AfterEach {
        & $PSScriptRoot\RestoreConfig.ps1
    }
    Context "All parameters" {
        It "Should generate module project" {
            $moduleName = 'MyModule'
            $version = '2.0'
            $description = 'My module'
            $author = 'John Doe'

            New-ModuleProject -DestinationPath "TestDrive:\$moduleName" -Description $description -Author $author -Version $version

            $psd1 = "TestDrive:\$moduleName\$moduleName\$moduleName.psd1"
            if (Test-Path $psd1) {
                $metadata = Import-LocalizedData -BaseDirectory (Split-Path $psd1) -FileName (Split-Path $psd1 -Leaf)
            }
            else {
                $metadata = @{}
            }

            $metadata.RootModule | Should be "$moduleName.psm1"
            $metadata.ModuleVersion | Should be $version
            $metadata.Description | Should be $description
            $metadata.Author | Should be $author
        }
    }
    Context "Hooks" {
        It "Should run hooks" {
            $configDir = Get-PoshForgeConfigurationPath
            $hooksDir = Join-Path $configDir hooks
            New-Item $hooksDir -ItemType Directory -Force | Out-Null
            Set-Content -Path $hooksDir\PreModuleProject.ps1 -Value "New-Item TestDrive:\pre.txt -ItemType File -Force" -Force
            Set-Content -Path $hooksDir\ModuleProject.ps1 -Value "New-Item TestDrive:\post.txt -ItemType File -Force" -Force

            Push-Location TestDrive:\
            try {
                New-ModuleProject foo description
            }
            finally {
                Pop-Location
            }

            Test-Path TestDrive:\pre.txt | Should be $true
            Test-Path TestDrive:\post.txt | Should be $true
        }
    }
}

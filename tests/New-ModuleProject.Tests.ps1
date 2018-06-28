param(
    [Parameter(Mandatory = $True)]
    $OutputDir
)

$module = Get-ChildItem -Path $OutputDir -Include PoshForge.psd1 -Recurse | Select-Object -First 1
Remove-Module PoshForge
Import-Module $module -Force

Describe "Get-ModuleTemplate" {
    BeforeEach {
        if (Test-Path ~/.poshforge) {
            Move-Item ~/.poshforge ~/.poshforge.bak | Out-Null
        }
    }
    AfterEach {
        if (Test-Path ~/.poshforge) {
            Remove-Item ~/.poshforge -Recurse -Force | Out-Null
        }
        if (Test-Path ~/.poshforge.bak) {
            Move-Item ~/.poshforge.bak ~/.poshforge | Out-Null
        }
    }
    Context "All parameters" {
        It "Should generate module project" {
            $moduleName = 'MyModule'
            $version = '2.0'
            $description = 'My module'
            $author = 'John Doe'

            New-ModuleProject -DestinationPath "TestDrive:\$moduleName" -Description $description -Author $author -ModuleVersion $version

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
            New-Item ~\.poshforge\hooks -ItemType Directory -Force | Out-Null
            Set-Content -Path ~\.poshforge\hooks\PreModuleProject.ps1 -Value "New-Item TestDrive:\pre.txt -ItemType File -Force" -Force
            Set-Content -Path ~\.poshforge\hooks\ModuleProject.ps1 -Value "New-Item TestDrive:\post.txt -ItemType File -Force" -Force

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

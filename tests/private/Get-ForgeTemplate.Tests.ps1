param(
    [Parameter(Mandatory = $True)]
    $OutputDir
)

$module = Get-ChildItem -Path $OutputDir -Include PoshForge.psd1 -Recurse | Select-Object -First 1
Remove-Module PoshForge -ErrorAction SilentlyContinue
Import-Module $module -Force

InModuleScope PoshForge {
    Describe "Get-ForgeTemplate" {
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
        Context "Template only in module templates" {
            It "Should return path" {
                $moduleDir = Split-Path (Get-Module PoshForge).Path
                $expected = Get-Item (Join-Path $moduleDir 'templates\ModuleProject')

                $result = Get-ForgeTemplate -Name ModuleProject

                $result.FullName | Should be $expected.FullName
            }
        }
        Context "Template in local templates" {
            It "Should return path" {
                $expected = New-Item -Path '~\.poshforge\templates\ModuleProject' -ItemType Directory -Force

                $result = Get-ForgeTemplate -Name ModuleProject

                $result.FullName | Should be $expected.FullName
            }
        }
    }
}
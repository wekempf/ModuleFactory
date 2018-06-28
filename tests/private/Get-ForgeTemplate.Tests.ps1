param(
    [Parameter(Mandatory = $True)]
    $OutputDir
)

$module = Get-ChildItem -Path $OutputDir -Include ModuleFactory.psd1 -Recurse | Select-Object -First 1
Remove-Module ModuleFactory -ErrorAction SilentlyContinue
Import-Module $module -Force

InModuleScope ModuleFactory {
    Describe "Get-ForgeTemplate" {
        BeforeEach {
            if (Test-Path ~/.modulefactory) {
                Move-Item ~/.modulefactory ~/.modulefactory.bak | Out-Null
            }
        }
        AfterEach {
            if (Test-Path ~/.modulefactory) {
                Remove-Item ~/.modulefactory -Recurse -Force | Out-Null
            }
            if (Test-Path ~/.modulefactory.bak) {
                Move-Item ~/.modulefactory.bak ~/.modulefactory | Out-Null
            }
        }
        Context "Template only in module templates" {
            It "Should return path" {
                $moduleDir = Split-Path (Get-Module ModuleFactory).Path
                $expected = Get-Item (Join-Path $moduleDir 'templates\ModuleProject')

                $result = Get-ForgeTemplate -Name ModuleProject

                $result.FullName | Should be $expected.FullName
            }
        }
        Context "Template in local templates" {
            It "Should return path" {
                $expected = New-Item -Path '~\.modulefactory\templates\ModuleProject' -ItemType Directory -Force

                $result = Get-ForgeTemplate -Name ModuleProject

                $result.FullName | Should be $expected.FullName
            }
        }
    }
}
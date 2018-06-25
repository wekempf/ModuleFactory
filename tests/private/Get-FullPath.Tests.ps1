param(
    [Parameter(Mandatory = $True)]
    $OutputDir
)

$module = Get-ChildItem -Path $OutputDir -Include ModuleFactory.psd1 -Recurse | Select-Object -First 1
Import-Module $module -Force

InModuleScope ModuleFactory {
    Describe "Get-FullPath" {
        Context "Path that does not exist" {
            It "Should return full path" {
                $expected = (Join-Path (Get-Location) 'xyzzy')

                $result = Get-FullPath 'xyzzy'

                $result | Should be $expected
            }
        }
    }
}
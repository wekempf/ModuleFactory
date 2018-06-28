param(
    [Parameter(Mandatory = $True)]
    $OutputDir
)

$module = Get-ChildItem -Path $OutputDir -Include PoshForge.psd1 -Recurse | Select-Object -First 1
Remove-Module PoshForge -ErrorAction SilentlyContinue
Import-Module $module -Force

InModuleScope PoshForge {
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
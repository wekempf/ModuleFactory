& $PSScriptRoot\..\ImportModule.ps1


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
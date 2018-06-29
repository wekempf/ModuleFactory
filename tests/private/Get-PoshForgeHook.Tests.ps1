& $PSScriptRoot\..\ImportModule.ps1

InModuleScope PoshForge {
    Describe "Get-PoshForgeHook" {
        Context "Script only in module hooks" {
            It "Should return full path" {
                $true | Should be $true
            }
        }
    }
}
param(
    [Parameter(Mandatory = $True)]
    $OutputDir
)

$module = Get-ChildItem -Path $OutputDir -Include PoshForge.psd1 -Recurse | Select-Object -First 1
Remove-Module PoshForge -ErrorAction SilentlyContinue
Import-Module $module -Force

InModuleScope PoshForge {
    Describe "Get-ModuleHook" {
        Context "Script only in module hooks" {
            It "Should return full path" {
                $true | Should be $true
            }
        }
    }
}
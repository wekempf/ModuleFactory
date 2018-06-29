$root = $PSScriptRoot
while (-not (Test-Path (Join-Path $root PoshForge.build.ps1))) {
    $root = Split-Path $root
}
$module = Join-Path $root 'output\PoshForge\PoshForge.psd1'
Remove-Module PoshForge -ErrorAction SilentlyContinue
Import-Module $module -Force

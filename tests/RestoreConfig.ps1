'Machine','Enterprise','User' | ForEach-Object {
    $dir = (Get-PoshForgeConfigurationPath -Scope $_)
    if (Test-Path $dir) {
        Remove-Item $dir -Recurse -Force | Out-Null
    }
    if (Test-Path "$dir.bak") {
        Move-Item "$dir.bak" $dir | Out-Null
    }
}
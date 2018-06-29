'Machine','Enterprise','User' | ForEach-Object {
    $dir = Get-PoshForgeConfigurationPath -Scope $_
    if (Test-Path $dir) {
        Move-Item $dir "$dir.bak" | Out-Null
    }
}
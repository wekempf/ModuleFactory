param($Path)
[bool](Get-ChildItem -Path (Join-Path $Path '*.build.ps1') -ErrorAction SilentlyContinue)
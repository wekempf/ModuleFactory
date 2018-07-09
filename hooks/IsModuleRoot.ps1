param($Path)
[bool](Get-ChildItem -Path (Join-Path $Path '*.psd1') -ErrorAction SilentlyContinue)
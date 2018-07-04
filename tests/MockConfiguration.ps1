$configPaths = @(
    $poshForgeDir
    'TestDrive:\Enterprise'
    'TestDrive:\Machine'
    'TestDrive:\User'
)
Mock -ModuleName PoshForge -CommandName Get-PoshForgeConfigurationPath {
    param($Scope)
    switch ($Scope) {
        "Enterprise" {
            $configPaths[1]
        }
        "Machine" {
            $configPaths[2]
        }
        "User" {
            $configPaths[3]
        }
        default {
            $configPaths[0]
        }
    }
}.GetNewClosure()
Mock -ModuleName PoshForge -CommandName Get-PoshForgeConfiguration {
    $config = @{}
    foreach ($path in $configPaths) {
        $configFile = Join-Path $path Configuration.psd1
        if (Test-Path $configFile) {
            $metadata = Import-Metadata $configFile
            $config = Update-Object -Input $config -Update $metadata
        }
    }
    $config
}.GetNewClosure()

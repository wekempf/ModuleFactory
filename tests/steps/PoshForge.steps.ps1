Import-Module "$PSScriptRoot\..\..\output\PoshForge\PoshForge.psd1" -Force

BeforeEachFeature {
    $script:poshForgeDir = Split-Path (Get-Module PoshForge).Path
}

BeforeEachScenario {
    Push-Location TestDrive:\

    $script:context = @{}

    # Keep plaster from calling Write-Host and messing up the report
    Mock -ModuleName Plaster -CommandName Write-Host {}
}

AfterEachScenario {
    Pop-Location
}

Given 'I am in a directory without a ''(?<Directory>.*?)'' directory' {
    param($Directory)

    Test-Path $Directory -PathType Container | Should be $False
}

When 'I execute New-ScriptModule with' {
    param($Data)
    . $PSScriptRoot\MockConfiguration.ps1

    $params = $Data | ConvertFrom-StringData
    New-ScriptModule @params
    $context['moduleDirectory'] = $params.DestinationPath
}

When 'I have configuration with the values' {
    param($Data)

    $config = $Data | ConvertFrom-StringData
    New-Item TestDrive:\User -ItemType Directory -Force | Out-Null
    Export-Metadata -Path TestDrive:\User\Configuration.psd1 -InputObject $config
}

When 'I execute New-ModuleProject with' {
    param($Data)
    . $PSScriptRoot\MockConfiguration.ps1

    $params = $Data | ConvertFrom-StringData
    New-ModuleProject @params
    $context['moduleProjectDirectory'] = $params.DestinationPath
    $moduleName = Split-Path $context['moduleProjectDirectory'] -Leaf
    $context['moduleDirectory'] = Join-Path $context['moduleProjectDirectory'] $moduleName
}

When 'I call Get-PoshForgeConfiguration' {
    $context['poshForgeConfiguration'] = Get-PoshForgeConfiguration
}

When 'I execute Update-PoshForgeConfiguration with' {
    param($Data)
    . $PSScriptRoot\MockConfiguration.ps1

    $params = $Data | ConvertFrom-StringData
    Update-PoshForgeConfiguration @params
}

When 'I call Get-PoshForgeConfigurationPath with scope ''(?<Scope>.*?)''' {
    param($Scope)

    $context['poshForgeConfigurationPath'] = Get-PoshForgeConfigurationPath -Scope $Scope
}

Then 'a ''(?<ModuleDirectory>.*?)'' module directory should be created' {
    param($ModuleDirectory)

    Test-Path $ModuleDirectory -PathType Container | Should be $True
}

Then 'a ''(?<ModuleProjectDirectory>.*?)'' module project directory should be created' {
    param($ModuleProjectDirectory)

    Test-Path $ModuleProjectDirectory -PathType Container | Should be $True
}

Then 'the module project directory should have a ''(?<ModuleDirectory>.*?)'' module directory' {
    param($ModuleDirectory)

    $path = Join-Path $context['moduleProjectDirectory'] $ModuleDirectory
    Test-Path $path -PathType Container | Should be $True
}

Then 'the module project directory should have a ''(?<DirectoryName>.*?)'' directory' {
    param($DirectoryName)

    $path = Join-Path $context['moduleProjectDirectory'] $DirectoryName
    Test-Path $path -PathType Container | Should be $True
}

Then 'the module project directory should have a ''(?<FileName>.*?)'' file' {
    param($FileName)

    $path = Join-Path $context['moduleProjectDirectory'] $FileName
    Test-Path $path -PathType Leaf | Should be $True
}

Then 'the module directory should have a ''(?<FileName>.*?)'' file' {
    param($FileName)

    $path = Join-Path $context['moduleDirectory'] $FileName
    Test-Path $path -PathType Leaf | Should be $True
}

Then 'the module directory should have a ''(?<DirectoryName>.*?)'' directory' {
    param($DirectoryName)

    $path = Join-Path $context['moduleDirectory'] $DirectoryName
    Test-Path $path -PathType Container | Should be $True
}

Then 'manifest should have a key ''(?<KeyName>.*?)'' with value ''(?<Value>.*?)''' {
    param($KeyName, $Value)

    $moduleName = Split-Path $context['moduleDirectory'] -Leaf
    $path = Join-Path $context['moduleDirectory'] "$moduleName.psd1"
    $manifest = Import-PowerShellDataFile $path
    $manifest[$KeyName] | Should be $Value
}

Then 'I should get the configuration values' {
    $context['poshForgeConfiguration'] | Should not be $null
}

Then 'I should get the configuration path' {
    $context['poshForgeConfigurationPath'] | Should not be $null
}

Then 'configuration should have property key ''(?<PropertyName>.*?)'' with value ''(?<Value>.*?)''' {
    param($PropertyName, $Value)
    #. $PSScriptRoot\MockConfiguration.ps1

    #$config = Get-PoshForgeConfiguration
    $config = Import-Metadata TestDrive:\User\Configuration.psd1
    $config[$PropertyName] | Should be $Value
}
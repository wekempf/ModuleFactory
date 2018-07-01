Import-Module "$PSScriptRoot\..\..\output\PoshForge\PoshForge.psd1" -Force

BeforeEachFeature {
    $script:poshForgeDir = Split-Path (Get-Module PoshForge).Path
}

BeforeEachScenario {
    Push-Location TestDrive:\

    $script:context = @{}
    $config = Import-Metadata "$poshForgeDir\Configuration.psd1"
    Mock -ModuleName PoshForge -CommandName Get-PoshForgeConfiguration {
        $config
    }.GetNewClosure()

    # Keep plaster from calling Write-Host and messing up the report
    Mock -ModuleName Plaster -CommandName Write-Host {}
}

AfterEachScenario {
    Pop-Location
}

Given 'I am in a directory without a ''(?<Directory>.*?)'' directory' {
    param($Directory)
    #Set-Location TestDrive:\
    Test-Path $Directory | Should be $False
    (Get-Location).Path | Should be 'TestDrive:\'
}

When 'I execute New-ScriptModule with' {
    param($Data)
    $params = $Data | ConvertFrom-StringData
    New-ScriptModule @params
    $context.moduleDirectory = $params.DestinationPath
}

When 'I have configuration with the values' {
    param($Data)
    $config = $Data | ConvertFrom-StringData
    Mock -ModuleName PoshForge -CommandName Get-PoshForgeConfiguration {
        $config
    }.GetNewClosure()
}

When 'I execute New-ModuleProject with' {
    param($Data)
    $params = $Data | ConvertFrom-StringData
    New-ModuleProject @params
    $context.moduleProjectDirectory = $params.DestinationPath
    $moduleName = Split-Path $context.moduleProjectDirectory -Leaf
    $context.moduleDirectory = Join-Path $context.moduleProjectDirectory $moduleName
}

When 'I call Get-PoshForgeConfiguration' {
    $context.poshForgeConfiguration = Get-PoshForgeConfiguration
}

Then 'a ''(?<ModuleDirectory>.*?)'' module directory should be created' {
    param($ModuleDirectory)
    Test-Path $ModuleDirectory | Should be $True
}

Then 'a ''(?<ModuleProjectDirectory>.*?)'' module project directory should be created' {
    param($ModuleProjectDirectory)
    Test-Path $ModuleProjectDirectory | Should be $True
}

Then 'the module project directory should have a ''(?<ModuleDirectory>.*?)'' module directory' {
    param($ModuleDirectory)
    $path = Join-Path $context.moduleProjectDirectory $ModuleDirectory
    Test-Path $path | Should be $True
}

Then 'the module directory should have a ''(?<FileName>.*?)'' file' {
    param($FileName)
    $path = Join-Path $context.moduleDirectory $FileName
    Test-Path $path -PathType Leaf | Should be $True
}

Then 'the module directory should have a ''(?<DirectoryName>.*?)'' directory' {
    param($DirectoryName)
    $path = Join-Path $context.moduleDirectory $DirectoryName
    Test-Path $path -PathType Container | Should be $True
}

Then 'manifest should have a key ''(?<KeyName>.*?)'' with value ''(?<Value>.*?)''' {
    param($KeyName, $Value)
    $moduleName = Split-Path $context.moduleDirectory -Leaf
    $path = Join-Path $context.moduleDirectory "$moduleName.psd1"
    $manifest = Import-PowerShellDataFile $path
    $manifest[$KeyName] | Should be $Value
}

Then 'I should get the configuration values' {
    $context.poshForgeConfiguration | Should not be $null
}
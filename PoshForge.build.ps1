$outputDir = Join-Path $PsScriptRoot 'output'
$moduleName = 'PoshForge'
$tools = Join-Path $PsScriptRoot '.tools'
$buildNumber = 0
$gitRepo = ((git remote -v | Select-String origin | select-object -first 1) -split '\s')[1]
$percentCompliance = 80

task InstallDependencies {
    New-Item $tools -ItemType Directory -Force | Out-Null
    if (-not (Get-Command Invoke-PSDepend -ErrorAction SilentlyContinue)) {
        if (-not (Test-Path (Join-Path $tools PSDepend))) {
            Save-Module -Name PSDepend -Path $tools
        }
        $oldModulePath = $env:PSModulePath
        $env:PSModulePath += ";$tools"
        try {
            Import-Module PSDepend
        }
        finally {
            $env:PSModulePath = $oldModulePath
        }
    }

    $install = @{
        PSDependOptions = @{
            Target = $tools
        }
        PSTestReport    = @{
            Name = 'https://github.com/Xainey/PSTestReport.git'
        }
    }
    $import = @{
        PSDependOptions  = @{
            Target = $tools
        }
        PSScriptAnalyzer = 'latest'
        Pester           = 'latest'
        Platyps          = 'latest'
    }
    $manifestFile = Join-Path $moduleName "$moduleName.psd1"
    $manifest = Import-PowerShellDataFile $manifestFile
    if ($manifest.ContainsKey('RequiredModules')) {
        @($manifest.RequiredModules) | ForEach-Object {
            $import[$_] = 'latest'
        }
    }
    Invoke-PSDepend -InputObject $install -Install -Confirm:$false
    Invoke-PSDepend -InputObject $import -Install -Import -Confirm:$false
}

task Clean {
    if (Test-Path -Path $OutputDir) {
        Remove-Item "$OutputDir/*" -Recurse -Force
    }
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
}

task Analyze InstallDependencies, {
    $saParams = @{
        Path        = $moduleName
        Recurse     = $true
        ExcludeRule = '*\templates\*'
    }
    $saResults = Invoke-ScriptAnalyzer @saParams
    $saResults | ConvertTo-Json | Set-Content (Join-Path $OutputDir 'ScriptAnalysisResults.json')
}

task Build Clean, InstallDependencies, Analyze, {
    $moduleDir = Join-Path $OutputDir $moduleName
    New-Item -ItemType Directory -Path $moduleDir -Force | Out-Null
    Copy-Item -Path "$moduleName/*" -Destination $moduleDir -Recurse -Force | Out-Null

    $docsDir = Join-Path $moduleDir 'en-US'
    New-ExternalHelp -Path "docs" -OutputPath $docsDir | Out-Null

    $templateDir = Join-Path $moduleDir 'templates'
    New-Item -ItemType Directory -Path $templateDir -Force | Out-Null
    Copy-Item -Path "templates/*" -Destination $templateDir -Recurse -Force | Out-Null

    $hooksDir = Join-Path $moduleDir 'hooks'
    New-Item -ItemType Directory -Path $hooksDir -Force | Out-Null
    Copy-Item -Path "hooks/*" -Destination $hooksDir -Recurse -Force | Out-Null
}

task _RunTests InstallDependencies, {
    $pesterParams = @{
        Path         = Join-Path $PsScriptRoot tests
        Outputfile   = Join-Path $OutputDir 'TestResults.xml'
        OutputFormat = 'NUnitXml'
        Strict       = $true
        PassThru     = $true
        EnableExit   = $false
        CodeCoverage = (Get-ChildItem -Path "$OutputDir/$moduleName/*.ps1" -Recurse | Where-Object { $_ -notmatch '.*\\(templates|hooks|private)\\' }).FullName
    }
    $pesterResults = Invoke-Gherkin @pesterParams
    $pesterResults | ConvertTo-Json -Depth 5 | Set-Content (Join-Path $OutputDir 'PesterResults.json')

    $psTestReportParams = @{
        BuildNumber        = $buildNumber
        GitRepo            = $gitRepo
        GetRepoUrl         = $gitRepo
        CiUrl              = $gitRepo
        ShowHitCommands    = $true
        Compliance         = ($percentCompliance / 100)
        ScriptAnalyzerFile = (Join-Path $OutputDir 'ScriptAnalysisResults.json')
        PesterFile         = (Join-Path $OutputDir 'PesterResults.json')
        OutputDir          = $OutputDir
    }
    . "$tools/PSTestReport/Invoke-PSTestReport.ps1" @psTestReportParams
}

task _ConfirmTestsPassed {
    [xml]$xml = Get-Content (Join-Path $OutputDir 'TestResults.xml')
    $numberFails = $xml."test-results".failures
    assert($numberFails -eq 0)('Failed "{0}" unit tests.' -f $numberFails)

    $json = Get-Content (Join-Path $outputDir 'PesterResults.json') | ConvertFrom-Json
    $overallCoverage = [Math]::Floor(($json.CodeCoverage.NumberOfCommandsExecuted / $json.CodeCoverage.NumberOfCommandsAnalyzed) * 100)
    assert($overallCoverage -gt $PercentCompliance)('A Code Coverage of "{0}" does not meet the build requirement of "{1}".' -f $overallCoverage,$PercentCompliance)
}

task Test Build, _RunTests, _ConfirmTestsPassed

task Install Build, {
    $destination = Join-Path "$home\Documents\WindowsPowerShell\Modules" $moduleName
    if (Test-Path $destination) {
        Remove-Item $destination -Recurse -Force
    }
    $moduleSource = Join-Path $outputDir $moduleName
    $source = Join-Path $moduleSource '*'
    New-Item -ItemType Directory -Path $destination -Force | Out-Null
    Copy-Item -Path $source -Destination $destination -Recurse -Force | Out-Null

    $manifestFile = Join-Path $moduleSource "$moduleName.psd1"
    $manifest = Import-PowerShellDataFile $manifestFile
    if ($manifest.ContainsKey('RequiredModules')) {
        @($manifest.RequiredModules) | ForEach-Object {
            Install-Module $_ -Scope CurrentUser
        }
    }
}

task . Test
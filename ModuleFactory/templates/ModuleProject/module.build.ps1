param(
    [string]$OutputDir = 'output'
)

task InstallDependencies {
    if (!(Test-Path -Path './tools/PSTestReport')) {
        New-Item -ItemType Directory -Path './tools' -Force
        Push-Location './tools'
        try {
            & git clone https://github.com/Xainey/PSTestReport.git
        }
        finally {
            Pop-Location
        }
    }
}

task Clean {
    if (Test-Path -Path $OutputDir) {
        Remove-Item "$OutputDir/*" -Recurse -Force
    }

    New-Item -ItemType Directory -Path $OutputDir -Force
}

task Analyze {
    $saParams = @{
        Path    = './<%= $PLASTER_PARAM_ModuleName %>'
        Recurse = $true
    }

    $saResults = Invoke-ScriptAnalyzer @saParams

    $saResults | ConvertTo-Json | Set-Content (Join-Path $OutputDir 'ScriptAnalysisResults.json')
}

task Build Clean, Analyze, {
    [void](New-Item -ItemType Directory -Path (Join-Path $OutputDir '<%= $PLASTER_PARAM_ModuleName %>'))
    [void](Copy-Item -Path '<%= $PLASTER_PARAM_ModuleName %>/*' -Destination (Join-Path $OutputDir '<%= $PLASTER_PARAM_ModuleName %>') -Recurse -Force)
}

task _RunTests InstallDependencies, {
    $pesterParams = @{
        Outputfile   = (Join-Path $OutputDir 'TestResults.xml')
        OutputFormat = 'NUnitXml'
        Strict       = $true
        PassThru     = $true
        EnableExit   = $false
        CodeCoverage = (Get-ChildItem -Path "$OutputDir/<%= $PLASTER_PARAM_ModuleName %>/*.ps1" -Recurse).FullName
    }

    $pesterResults = Invoke-Pester @pesterParams

    $pesterResults | ConvertTo-Json -Depth 5 | Set-Content (Join-Path $OutputDir 'PesterResults.json')

    $psTestReportParams = @{
        BuildNumber        = $BuildNumber
        GitRepo            = $Settings.GitRepo
        GetRepoUrl         = $Settings.ProjectUrl
        CiUrl              = $Settings.CiUrl
        ShowHitCommands    = $true
        Compliance         = ($PercentCompliance / 100)
        ScriptAnalyzerFile = (Join-Path $OutputDir 'ScriptAnalysisResults.json')
        PesterFile         = (Join-Path $OutputDir 'PesterResults.json')
        OutputDir          = $OutputDir
    }

    . './tools/PSTestReport/Invoke-PSTestReport.ps1' @psTestReportParams
}

task _ConfirmTestsPassed {
    [xml]$xml = Get-Content (Join-Path $OutputDir 'TestResults.xml')
    $numberFails = $xml."test-results".failures
    assert($numberFails -eq 0)('Failed "{0}" unit tests.' -f $numberFails)

    $json = Get-Content (Join-Path $outputDir 'PesterResults.json') | ConvertFrom-Json
    $overallCoverage = [Math]::Floor(($json.CodeCoverage.NumberOfCommandsExecuted / $json.CodeCoverage.NumberOfCommandsAnalyzed) * 100)
    assert($overallCoverage -gt $PercentCompliance)('A Code Coverage of "{0}" does not meet the build requirement of "{1}".' -f $overallCoverage,$PercentCompliance)
}

task Test _RunTests, _ConfirmTestsPassed

task . Build, Test
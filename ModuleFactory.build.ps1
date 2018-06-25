param(
    [string]$OutputDir = (Join-Path $PsScriptRoot 'output')
)

$tools = Join-Path $PsScriptRoot '.tools'
$buildNumber = 0
$gitRepo = ((git remote -v | Select-String origin | select-object -first 1) -split '\s')[1]
$percentCompliance = 80

task InstallDependencies {
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
    }
    if (-not (Test-Path (Join-Path $tools 'PSDepend'))) {
        New-Item -Path $tools -ItemType Directory -Force | Out-Null
        Save-Module -Name PSDepend -Path $tools
        Import-Module (Get-ChildItem -Path $tools -Include PSDepend.psd1 -Recurse)
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
        Path    = 'ModuleFactory'
        Recurse = $true
    }
    $saResults = Invoke-ScriptAnalyzer @saParams
    $saResults | ConvertTo-Json | Set-Content (Join-Path $OutputDir 'ScriptAnalysisResults.json')
}

task Build Clean, Analyze, {
    [void](New-Item -ItemType Directory -Path (Join-Path $OutputDir 'ModuleFactory'))
    [void](Copy-Item -Path 'ModuleFactory/*' -Destination (Join-Path $OutputDir 'ModuleFactory') -Recurse -Force)
}

task _RunTests InstallDependencies, {
    $pesterParams = @{
        Script       = @{ Path = (Join-Path $PsScriptRoot tests); Parameters = @{ OutputDir = $OutputDir } }
        Outputfile   = (Join-Path $OutputDir 'TestResults.xml')
        OutputFormat = 'NUnitXml'
        Strict       = $true
        PassThru     = $true
        EnableExit   = $false
        CodeCoverage = (Get-ChildItem -Path "$OutputDir/ModuleFactory/*.ps1" -Recurse | Where-Object { $_ -notmatch '.*\\templates\\'}).FullName
    }
    $pesterResults = Invoke-Pester @pesterParams
    $pesterResults | ConvertTo-Json -Depth 5 | Set-Content (Join-Path $OutputDir 'PesterResults.json')

    # $psTestReportParams = @{
    #     BuildNumber        = $buildNumber
    #     GitRepo            = $gitRepo
    #     GetRepoUrl         = $gitRepo
    #     CiUrl              = $gitRepo
    #     ShowHitCommands    = $true
    #     Compliance         = ($percentCompliance / 100)
    #     ScriptAnalyzerFile = (Join-Path $OutputDir 'ScriptAnalysisResults.json')
    #     PesterFile         = (Join-Path $OutputDir 'PesterResults.json')
    #     OutputDir          = $OutputDir
    # }
    # . "$tools/PSTestReport/Invoke-PSTestReport.ps1" @psTestReportParams
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

task . Test
[CmdletBinding()]
param (
    [Parameter(Position = 0, Mandatory = $False)]
    $Task = '.'
)

begin {
}

process {
    if (-not (Get-Command 'Invoke-Build')) {
        $tools = Join-Path $PsScriptRoot '.tools'
        $invokeBuild = Get-ChildItem -Path $tools -Include InvokeBuild.psd1 -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
        if (-not $invokeBuild) {
            New-Item -Path $tools -ItemType Directory -Force | Out-Null
            Save-Module -Name InvokeBuild -Path $tools
            $invokeBuild = Get-ChildItem -Path $tools -Include InvokeBuild.psd1 -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
        }
        Import-Module $invokeBuild
    }
    Push-Location $PsScriptRoot
    try {
        Invoke-Build -Task $Task
    }
    finally {
        Pop-Location
    }
}

end {
}

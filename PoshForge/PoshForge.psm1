#Get public and private function definition files.
$ModuleRoot = $PSScriptRoot
$Public = @(Get-ChildItem -Path $ModuleRoot\Public\*.ps1 -ErrorAction SilentlyContinue)
$Private = @(Get-ChildItem -Path $ModuleRoot\Private\*.ps1 -ErrorAction SilentlyContinue)
$Classes = @(Get-ChildItem -Path $ModuleRoot\Classes\*.ps1 -ErrorAction SilentlyContinue)

#Dot source the files
foreach ($import in @($Public + $Private + $Classes)) {
    try {
        . $import.fullname
    }
    catch {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

Export-ModuleMember -Function $Public.Basename
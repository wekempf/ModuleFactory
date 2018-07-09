function Get-ScriptModuleRoot {
    [CmdletBinding()]
    [OutputType([System.IO.DirectoryInfo])]
    param ()

    begin {
        $isProjectRoot = Get-PoshForgeHook IsProjectRoot
        $isModuleRoot = Get-PoshForgeHook IsModuleRoot
    }

    process {
        $path = Get-Location
        while ($path) {
            if (& $isModuleRoot $path) {
                return Resolve-Path $path
            }
            elseif (& $isProjectRoot $path) {
                foreach ($modulePath in (Get-ChildItem -Path $path -Directory)) {
                    $modulePath = Join-Path $path $modulePath
                    if (& $isModuleRoot $modulePath) {
                        return Resolve-Path $modulePath
                    }
                }
            }
            else {
                $path = Split-Path $path
            }
        }
    }

    end {
    }
}
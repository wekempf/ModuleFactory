function Get-ModuleProjectRoot {
    [CmdletBinding()]
    [OutputType([System.IO.DirectoryInfo])]
    param ()

    begin {
        $isProjectRoot = Get-PoshForgeHook IsProjectRoot
    }

    process {
        $path = Get-Location
        while ($path) {
            if (& $isProjectRoot $path) {
                return Resolve-Path $path
            }
            else {
                $path = Split-Path $path
            }
        }
    }

    end {
    }
}
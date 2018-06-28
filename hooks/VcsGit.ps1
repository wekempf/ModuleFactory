[CmdletBinding()]
param (
    [Parameter(Position = 0, Mandatory = $true)]
    [string]$Name,

    [Parameter(Position = 1, Mandatory = $true)]
    [string]$DestinationPath,

    [Parameter(ValueFromRemainingArguments = $True)]
    $Arguments
)

begin {
    Push-Location $DestinationPath
}

process {
    git init
}

end {
    Pop-Location
}

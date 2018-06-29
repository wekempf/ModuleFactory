function Invoke-ForgeTemplate {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [string]$Name,

        [Parameter(Position = 1, Mandatory = $true)]
        [string]$DestinationPath,

        [Parameter(Position = 2, Mandatory = $False)]
        [Hashtable]$Arguments,

        [Switch]$Force
    )

    begin {
        if (-not $PSBoundParameters.ContainsKey('Confirm')) {
            $ConfirmPreference = $PSCmdlet.SessionState.PSVariable.GetValue('ConfirmPreference')
        }
        if (-not $PSBoundParameters.ContainsKey('WhatIf')) {
            $WhatIfPreference = $PSCmdlet.SessionState.PSVariable.GetValue('WhatIfPreference')
        }
        if (-not $PSBoundParameters.ContainsKey('Verbose')) {
            $VerbosePreference = $PSCmdlet.SessionState.PSVariable.GetValue('VerbosePreference')
        }
        $pre = Get-PoshForgeHook "Pre$Name"
        $post = Get-PoshForgeHook $Name
        $template = Get-PoshForgeTemplate $Name
    }

    process {
        if ($template) {
            $params = @{
                'TemplatePath'    = $template
                'DestinationPath' = $DestinationPath
                'NoLogo'          = $true
                'Force'           = $Force
            }
            $hookParams = @{
                Name            = $Name
                DestinationPath = $DestinationPath
            }
            if ($Arguments) {
                $params += $Arguments
                $hookParams += $Arguments
            }
            if ($pre) {
                & $pre @hookParams
            }
            Invoke-Plaster @params
            if ($post) {
                & $post @hookParams
            }
        }
    }

    end {
    }
}
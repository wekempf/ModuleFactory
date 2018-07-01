function New-DynamicParameter {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "", Justification="Private function that doesn't actually modify any permanent state.")]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $False, ValueFromPipeline = $True)]
        [System.Management.Automation.RuntimeDefinedParameterDictionary]$InputObject,

        [Parameter(Position = 0, Mandatory = $True)]
        [string]$Name,

        [Parameter(Position = 1, Mandatory = $False)]
        [Type]$Type = [object],

        [Parameter(Mandatory = $False)]
        [int]$Position,

        [Parameter(Mandatory = $False)]
        [string]$ParameterSetName,

        [Parameter(Mandatory = $False)]
        [string]$HelpMessage,

        [Parameter(Mandatory = $False)]
        [System.Management.Automation.ValidateArgumentsAttribute[]]$ValidateAttribute,

        [Parameter(Mandatory = $False)]
        [string[]]$ValidateSet,

        [switch]$Mandatory,

        [switch]$ValueFromPipeline,

        [switch]$ValueFromPipelineByPropertyName,

        [switch]$ValueFromRemainingArguments
    )

    begin {
    }

    process {
        if (-not $PSBoundParameters.ContainsKey('InputObject')) {
            $InputObject = New-Object -Type System.Management.Automation.RuntimeDefinedParameterDictionary
        }
        $attrib = New-Object -Type System.Management.Automation.ParameterAttribute
        if ($PSBoundParameters.ContainsKey('Position')) {
            $attrib.Position = $Position
        }
        if ($PSBoundParameters.ContainsKey('ParameterSetName')) {
            $attrib.ParameterSetName = $ParameterSetName
        }
        if ($PSBoundParameters.ContainsKey('HelpMessage')) {
            $attrib.HelpMessage = $HelpMessage
        }
        $attrib.Mandatory = $Mandatory
        $attrib.ValueFromPipeline = $ValueFromPipeline
        $attrib.ValueFromPipelineByPropertyName = $ValueFromPipelineByPropertyName
        $attrib.ValueFromRemainingArguments = $ValueFromRemainingArguments
        $attributes = New-Object -Type System.Collections.ObjectModel.Collection[System.Attribute]
        $attributes.Add($attrib)
        $ValidateAttribute | ForEach-Object { $attributes.Add($_) }
        if ($ValidateSet) {
            $validateSetAttrib = New-Object System.Management.Automation.ValidateSetAttribute($ValidateSet)
            $attributes.Add($validateSetAttrib)
        }
        $param = New-Object -Type System.Management.Automation.RuntimeDefinedParameter($Name, $Type, $attributes)
        $InputObject.Add($Name, $param)
        $InputObject
    }

    end {
    }
}
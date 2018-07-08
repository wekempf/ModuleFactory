---
external help file: PoshForge-help.xml
Module Name: poshforge
online version: https://poshforge.readthedocs.io/en/latest/help/Get-PoshForgeConfiguration/
schema: 2.0.0
---

# Get-PoshForgeConfiguration

## SYNOPSIS

Gets the PoshForge configuration values.

## SYNTAX

```powershell
Get-PoshForgeConfiguration [<CommonParameters>]
```

## DESCRIPTION

Get's the PoshForge configuration values.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PoshForgeConfiguration
```

Returns a hashtable of the configuration values.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### Hashtable

## NOTES

The values returned are applied in the scope order Machine, Enterprise and User. The configuration values
control the behavior of the scaffolding commands.

## RELATED LINKS

[about_PoshForge](about_PoshForge)
[about_PoshForge_Configuration](about_PoshForge_Configuration)
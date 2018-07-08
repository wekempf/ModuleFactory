---
external help file: PoshForge-help.xml
Module Name: poshforge
online version: https://poshforge.readthedocs.io/en/latest/help/Get-PoshForgeConfigurationPath/
schema: 2.0.0
---

# Get-PoshForgeConfigurationPath

## SYNOPSIS

Gets the PoshForge configuration path.

## SYNTAX

```powershell
Get-PoshForgeConfigurationPath [[-Scope] <String>] [<CommonParameters>]
```

## DESCRIPTION

Gets the path to the directory at the specified scope that contains the PoshForge configuration files.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PoshForgeConfigurationPath -Scope Enterprise
```

Gets the path to the configuration files at the Enterprise scope.

## PARAMETERS

### -Scope

Specifies the scope at which the configuration files will be applied.

This parameter is not required. If not specified the path to the User scope will be returned. The configuration
is applied in the scope order Machine, Enterprise and User.


```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: User, Machine, Enterprise

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.String

## NOTES

The configuration files control the behavior of the scaffolding commands.

## RELATED LINKS

[about_PoshForge](about_PoshForge)
[about_PoshForge_Configuration](about_PoshForge_Configuration)
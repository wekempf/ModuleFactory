---
external help file: PoshForge-help.xml
Module Name: poshforge
online version:
schema: 2.0.0
---

# New-ScriptModule

## SYNOPSIS

Scaffolds out a new script module.

## SYNTAX

```powershell
New-ScriptModule [-Path] <String> [-Description] <String> [-Author <String>] [-Version <Version>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Scaffolds out a new script module complete with documentation support, and custom type formating.

## EXAMPLES

### Example 1

```powershell
PS C:\> New-ScriptModule -Path MyModule -Description 'A simple module.'
```

Creates a module named MyModule in .\MyModule with the description 'A simple module.'.

## PARAMETERS

### -Author

Specifies the module author.

If you omit this parameter, New-ScriptModule will first try to use the Author key specified in the configuration
(see about_PoshForge_Configuration) or the name of the current user.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description

Specifies the description of the module.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DestinationPath

Specifies the path to a directory to place the module files.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Version

Specifies the version of the module.

This parameter is not required by the cmdlet. If you omit this parameter, New-ModuleProject creates a ModuleVersion
key with either the Version key specified in the configuration (see about_PoshForge_Configuration) or a value of "1.0".

```yaml
Type: Version
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
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

### None

## NOTES

You can configure the template for the module created by this cmdlet. See about_PoshForge_Configuration
for more information.

## RELATED LINKS

[about_PoshForge_Configuration](about_PoshForge_Configuration)
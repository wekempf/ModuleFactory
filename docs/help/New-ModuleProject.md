---
external help file: PoshForge-help.xml
Module Name: poshforge
online version:
schema: 2.0.0
---

# New-ModuleProject

## SYNOPSIS

Scaffolds out a new module project.

## SYNTAX

```powershell
New-ModuleProject [-DestinationPath] <String> [-Description] <String> [-Author <String>]
 [-ModuleVersion <Version>] [-Force] [-WhatIf] [-Confirm] [-VersionControl <String[]>] [<CommonParameters>]
```

## DESCRIPTION

Scaffolds out a new module project complete with a build script, documentation support, custom type formating,
dependency management and unit tests.

## EXAMPLES

### Example 1

```powershell
PS C:\> New-ModuleProject -Path MyModule -Description 'A simple module.'
```

Creates a module project named MyModule in .\MyModule with the description 'A simple module.'.

## PARAMETERS

### -DestinationPath

Specifies the path to a directory to place the module project files.

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

### -Description

Specifies the description of the module.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Author

Specifies the module author.

If you omit this parameter, New-ModuleProject will first try to use the Author key specified in the configuration
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

### -Force

Forces this cmdlet to override the confirmation prompt and allow the cmdlet to overwrite existing files.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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

### -VersionControl

Specifies the version control system to use.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

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

You can configure the template for the module project created by this cmdlet. See about_PoshForge_Configuration
for more information.

## RELATED LINKS

[about_PoshForge_Configuration](about_PoshForge_Configuration)

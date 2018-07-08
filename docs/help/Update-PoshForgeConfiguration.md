---
external help file: PoshForge-help.xml
Module Name: poshforge
online version: https://poshforge.readthedocs.io/en/latest/help/Update-PoshForgeConfiguration/
schema: 2.0.0
---

# Update-PoshForgeConfiguration

## SYNOPSIS

Updates a PoshForge configuration value.

## SYNTAX

```
Update-PoshForgeConfiguration [-PropertyName] <String> [-Value] <String> [-Scope <String>] [<CommonParameters>]
```

## DESCRIPTION

Update-PoshForgeConfiguration updates a PoshForge configuration value.

## EXAMPLES

### Example 1

```powershell
PS C:\> Update-PoshForgeConfiguration -PropertyName Author -Value 'John Doe'
```

Updates the 'Author' configuration property with the value 'John Doe'.

## PARAMETERS

### -PropertyName

The name of the configuration property to update.

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

### -Scope

The scope at which to update the value.

This parameter is not required. If not specified the value will be updated in the User scope. The final
value used is applied in the scope order Machine, Enterprise and User.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: User, Machine, Enterprise

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value

The value to set the configuration property to.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### Hashtable

## NOTES

The configuration values control the behavior of the scaffolding commands.

## RELATED LINKS

[about_PoshForge](about_PoshForge)
[about_PoshForge_Configuration](about_PoshForge_Configuration)
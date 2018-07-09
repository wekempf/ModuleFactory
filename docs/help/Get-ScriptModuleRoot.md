---
external help file: PoshForge-help.xml
Module Name: PoshForge
online version: https://poshforge.readthedocs.io/en/latest/help/Get-ScriptModuleRoot/
schema: 2.0.0
---

# Get-ScriptModuleRoot

## SYNOPSIS

Gets the root directory of a script module from anywhere within the module, or from anywhere within
a module project.

## SYNTAX

```
Get-ScriptModuleRoot [<CommonParameters>]
```

## DESCRIPTION

Gets the root directory of a script module from anywhere within the module, or from anywhere within
a module project.

## EXAMPLES

### Example 1

```powershell
PS C:\Modules\MyModule\public\> Get-ScriptModuleRoot
```

Gets the path to the root directory ('C:\Modules\MyModule') of the script module.

### Example 2

```powershell
PS C:\Modules\MyModule\docs\> Get-ScriptModuleRoot
```

Gets the path to the root directory ('C:\Modules\MyModule\MyModule') of the script module.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.IO.DirectoryInfo

## NOTES

Because what constitutes a "module project root directory" is based on the structure and templates
used to create it, which is user configurable, a hook script (IsProjectRoot.ps1) can be created
to control this.

## RELATED LINKS

[about_PoshForge](about_PoshForge)
[about_PoshForge_Configuration](about_PoshForge_Configuration)
[Get-ScriptModuleRoot](Get-ModuleProjectRoot)
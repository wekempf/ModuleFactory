---
external help file: PoshForge-help.xml
Module Name: PoshForge
online version: https://poshforge.readthedocs.io/en/latest/help/Get-ModuleProjectRoot/
schema: 2.0.0
---

# Get-ModuleProjectRoot

## SYNOPSIS

Gets the root directory of a module project from anywhere within the project.

## SYNTAX

```
Get-ModuleProjectRoot [<CommonParameters>]
```

## DESCRIPTION

Gets the root directory of a module project from anywhere within the project.

## EXAMPLES

### Example 1

```powershell
PS C:\MyModule\MyModule\public\> Get-ModuleProjectRoot
```

Gets the path to the root directory ('C:\MyModule') of the module project.

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
[Get-ScriptModuleRoot](Get-ScriptModuleRoot)
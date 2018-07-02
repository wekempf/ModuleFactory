# PoshForge

## about_PoshForge

# SHORT DESCRIPTION

PoshForge is a module that provides cmdlets used to scaffold common PowerShell artifacts.

# LONG DESCRIPTION

PoshForge provides a set of cmdlets used to scaffold module projects, script modules, functions, scripts
and other PowerShell artifacts. PoshForge provides a comprehensive out-of-the-box set of templates,
but is highly configurable to work the way you want. PoshForge's cmdlets use Plaster as the template
engine but simplifies usage patterns to make it quick and easy to create the PowerShell artifacts you need.

## Module Project Creation

The heart of PoshForge is it's ability to create module projects. A module project provides a build system
that can take a structured set of files and generate a full featured module and even publish it to
[PowerShell Gallery](https://www.powershellgallery.com) or other module repositories. You can host these
module projects in a version control repository such as GitHub.

To create a module project you use the New-ModuleProject cmdlet.

```powershell
PS C:\> New-ModuleProject -Path MyModule -Description 'A simple module.'
```

# EXAMPLES

```powershell
PS C:\> New-ModuleProject -Path MyModule -Description 'A simple module.'
```


# NOTE

PoshForge provides a comprehensive set of templates but you may configure it to provide your own
set of default values and templates. See about_PoshForge_Configuration for more information.

# TROUBLESHOOTING NOTE

Currently PoshForge is under development and is not yet feature complete.

# SEE ALSO

about_PoshForge_Configuration

# KEYWORDS

- Scaffolding
- Modules
- Functions
- Scripts
- Cmdlets

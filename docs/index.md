# PoshForge

> NOTE: This is pre-release documentation and is very likely not accurate or complete.

A scaffolding framework for creating PowerShell projects, modules and scripts.

Project site: [https://github.com/wekempf/PoshForge](https://github.com/wekempf/PoshForge)

## What is PoshForge

A scaffolding framework for PowerShell based on [Plaster](https://github.com/PowerShell/Plaster)
templates. The templates and scaffolding behavior is highly configurable, providing an out-of-the-box
experience that is complete and comprehensive.

## Why use PoshForge

PoshForge makes it quick and easy to create even the most complex of PowerShell module projects.
To understand why let's look at some of the features.

### Features

* Generate an initial module project with a single command that includes the following.
  * A build.ps1 script that builds your module on any machine, with only a requirement on PowerShell 5.0.
    * Out-of-the-box this build system based on Invoke-Build, but you can change the templates to
          use any build system you like, such as Psake.
  * A module source directory with public, private and classes folders to keep code organized.
  * A docs directory with ReadTheDocs and PlatyPS based external help documentation based on Markdown files.
  * Pester testing support, including report generation with code coverage.
  * README.md and LICENSE files.
  * Version Control System support.
  * Editor support.
* Generate simpler script modules when you don't intend to distribute the module or need advanced functionality
  such as tests or external documentation.
* Generate script based cmdlets when you don't need full module support.
* Generate functions inside of module projects or simpler script modules.
* Generate classes inside of module projects or simpler script modules.
* Generate type formatting .ps1xml files.
* Generate test scripts.

## Installation

PoshForge is available on the [PowerShell Gallery](https://www.powershellgallery.com/packages/PoshForge).

To inspect:

```powershell
Save-Module -Name PoshForge -Path <path>
```

To install:

```powershell
Install-Module -Name PoshForge -Scope CurrentUser
```

You can also install from source:

```powershell
.\build.ps1 install
```

## Contributing

[Notes on contributing to this project.](Contributing.md)

## Change Log

[Change notes for each release.](ChangeLog.md)

## Aknowledgements

[Other projects or sources of inspiration.](Acknowledgements.md)
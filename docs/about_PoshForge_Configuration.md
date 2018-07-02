# PoshForge_Configuration

## about_PoshForge_Configuration

# SHORT DESCRIPTION

PoshForge uses a flexible configuration system to allow customization of how commands behave.

# LONG DESCRIPTION

PoshForge can be configured to use certain values for parameters not explicitly specified by creating a Configuration.psd1 in one of the directories returned by Get-PoshForgeConfigurationPath. Configuration values are obtained by merging the Configuration.psd1 in each of the configuration directories in the Scope order of Enterprise, Machine, User.

Plaster templates used by the various commands can be customized by creating a template in a template directory in one of the configuration directories returned by Configuration.psd1.

Code can be run before a template is is invoked by creating a Pre{TemplateName}.ps1 file in a hooks directory in one of the configuration directories returned by Configuration.psd1.

Code can be run after a template is is invoked by creating a {TemplateName}.ps1 file in a hooks directory in one of the configuration directories returned by Configuration.psd1.


## Optional Subtopics

{{ Optional Subtopic Placeholder }}

# EXAMPLES

{{ Code or descriptive examples of how to leverage the functions described. }}

# NOTE

{{ Note Placeholder - Additional information that a user needs to know.}}

# TROUBLESHOOTING NOTE

{{ Troubleshooting Placeholder - Warns users of bugs}}

{{ Explains behavior that is likely to change with fixes }}

# SEE ALSO

about_PoshForge


# KEYWORDS

{{List alternate names or titles for this topic that readers might use.}}

- {{ Keyword Placeholder }}
- {{ Keyword Placeholder }}
- {{ Keyword Placeholder }}
- {{ Keyword Placeholder }}

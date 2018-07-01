Feature: Get-PoshForgeConfigurationPath
    As a PowerShell developer I'd like to be able to get the path to the configuration directories.

    Scenario: Getting machine configuration path.
        When I call Get-PoshForgeConfigurationPath with scope 'Machine'
        Then I should get the configuration path

    Scenario: Getting enterprise configuration path.
        When I call Get-PoshForgeConfigurationPath with scope 'Enterprise'
        Then I should get the configuration path

    Scenario: Getting user configuration path.
        When I call Get-PoshForgeConfigurationPath with scope 'User'
        Then I should get the configuration path
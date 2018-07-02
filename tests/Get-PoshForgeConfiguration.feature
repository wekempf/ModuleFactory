Feature: Get-PoshForgeConfiguration
    As a PowerShell developer I'd like to be able to read PoshForge's configuration values.

    Scenario: Getting configuration values.
        When I call Get-PoshForgeConfiguration
        Then I should get the configuration values

Feature: Update-PoshForgeConfiguration
    As a PowerShell develop I want to be able to update PoshForge's configuration easily.

    Scenario: Update configuration.
        When I execute Update-PoshForgeConfiguration with
            """
            PropertyName = Author
            Value = Jack Ryan
            """
        Then configuration should have property key 'Author' with value 'Jack Ryan'

    Scenario: Update configuration twice.
        When I execute Update-PoshForgeConfiguration with
            """
            PropertyName = Author
            Value = Jack Ryan
            """
        And I execute Update-PoshForgeConfiguration with
            """
            PropertyName = Version
            Value = 7.0
            """
        Then configuration should have property key 'Author' with value 'Jack Ryan'
        And configuration should have property key 'Version' with value '7.0'

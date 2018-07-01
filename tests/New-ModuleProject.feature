Feature: New-ModuleProject
    As a PowerShell developer I'd like to be able to scaffold a new module project.

    Scenario: Scaffolding a simple module project.
        Given I am in a directory without a 'MyModule' directory
        When I execute New-ModuleProject with
            """
            DestinationPath = MyModule
            Description = A simple module.
            """
        Then a 'MyModule' module project directory should be created
        And the module project directory should have a 'MyModule' module directory
        And the module directory should have a 'MyModule.psd1' file
        And the module directory should have a 'MyModule.psm1' file
        And the module directory should have a 'public' directory
        And the module directory should have a 'private' directory
        And the module directory should have a 'classes' directory

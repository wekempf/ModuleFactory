Feature: New-ScriptModule
    As a module author, I want to be able to scaffold new script modules.

    Scenario: Scaffolding a simple module.
        Given I am in a directory without a 'MyModule' directory
        When I execute New-ScriptModule with
            """
            DestinationPath = MyModule
            Description = A simple module.
            """
        Then a 'MyModule' module directory should be created
        And the module directory should have a 'MyModule.psd1' file
        And the module directory should have a 'MyModule.psm1' file
        And the module directory should have a 'public' directory
        And the module directory should have a 'private' directory
        And the module directory should have a 'classes' directory

    Scenario: Module manifest should contain specified values.
        Given I am in a directory without a 'MyModule' directory
        When I execute New-ScriptModule with
            """
            DestinationPath = MyModule
            Description = A simple module.
            Author = John Doe
            Version = 2.0
            """
        Then manifest should have a key 'Description' with value 'A simple module.'
        And manifest should have a key 'Author' with value 'John Doe'
        And manifest should have a key 'ModuleVersion' with value '2.0'
        And manifest should have a key 'RootModule' with value 'MyModule.psm1'

    Scenario: Module scaffolding should use configuration values when not specified.
        Given I am in a directory without a 'MyModule' directory
        When I have configuration with the values
            """
            Author = Jane Doe
            Version = 7.0
            """
        And I execute New-ScriptModule with
            """
            DestinationPath = MyModule
            Description = A simple module.
            """
        Then manifest should have a key 'Author' with value 'Jane Doe'
        And manifest should have a key 'ModuleVersion' with value '7.0'

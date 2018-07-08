$poshForge = "$PSScriptRoot\..\output\PoshForge\PoshForge.psd1"
Import-Module $poshForge -Force

Describe "Get-Help" {
    $projectRoot = Resolve-Path "$PSScriptRoot\.."
    $docsDir = '.\docs'
    $helpDir = Join-Path $docsDir 'help'
    $commands = Get-Command -Module PoshForge -CommandType Function
    Context 'Module' {
        It 'Should have PlatyPS markdown file ''.\docs\help\about_PoshForge.md''' {
            $path = Join-Path $helpDir 'about_PoshForge.md'
            Test-Path $path -PathType Leaf | Should be $true
        }
    }
    Context 'Cmdlets' {
        foreach ($command in $commands) {
            $markdownFile = Join-Path $helpDir "$command.md"
            It "Should have PlatyPS markdown file $markdownFile" {
                $path = Join-Path $projectRoot $markdownFile
                Test-Path $path -PathType Leaf | Should Be $true
            }
            It "Should not have placeholder text in $markdownFile" {
                $path = Join-Path $projectRoot $markdownFile
                Select-String -Path $path -Pattern '{{.*?}}' | Should be $null
            }
            It "Should have a HelpUri for $command" {
                $command.HelpUri | Should Not BeNullOrEmpty
            }

            $help = Get-Help $command
            It "Should have related links for $command" {
                $help.relatedLinks.navigationLink.uri.count | Should BeGreaterThan 0
            }
            It "Should have a description for $command" {
                $help.description | Should Not BeNullOrEmpty
            }
            It "Should have an example for $command" {
                $help.examples | Should Not BeNullOrEmpty
            }

            foreach ($parameter in $help.parameters.parameter) {
                if ($parameter -notmatch 'whatif|confirm') {
                    It "Should have parameter description for parameter $($parameter.Name) in command $command" {
                        $parameter.Description.text | Should Not BeNullOrEmpty
                    }
                }
            }
        }
    }
}
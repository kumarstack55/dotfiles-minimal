BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "Move-MyFileItemToDatePrefixedFolder" {
    Context "Path is not date prefixed" {
        It "Makes directory based on filename and move file into it" {
            New-Item -Type Directory -Path "TestDrive:\folder" | Out-Null
            New-Item -Type File -Path "TestDrive:\folder\file1.txt" | Out-Null
            "test" | Set-Content -Path "TestDrive:\folder\file1.txt"

            Move-MyFileItemToDatePrefixedFolder "TestDrive:\folder\file1.txt"

            Test-Path -LiteralPath "TestDrive:\folder\file1.txt" | Should -Be $false
            Test-Path -LiteralPath "TestDrive:\folder\$(Get-Date -Format 'yyyyMMdd')_file1" | Should -Be $true
            Test-Path -LiteralPath "TestDrive:\folder\$(Get-Date -Format 'yyyyMMdd')_file1\file1.txt" | Should -Be $true
            Get-Content -Path "TestDrive:\folder\$(Get-Date -Format 'yyyyMMdd')_file1\file1.txt" | Should -Be "test"
        }
    }
    Context "Path is date prefixed" {
        It "Makes directory and move file into it" {
            New-Item -Type Directory -Path "TestDrive:\folder" | Out-Null
            New-Item -Type File -Path "TestDrive:\folder\20250131_file1.txt" | Out-Null
            "test" | Set-Content -Path "TestDrive:\folder\20250131_file1.txt"

            Move-MyFileItemToDatePrefixedFolder "TestDrive:\folder\20250131_file1.txt"

            Test-Path -LiteralPath "TestDrive:\folder\20250131_file1.txt" | Should -Be $false
            Test-Path -LiteralPath "TestDrive:\folder\20250131_file1" | Should -Be $true
            Test-Path -LiteralPath "TestDrive:\folder\20250131_file1\20250131_file1.txt" | Should -Be $true
            Get-Content -Path "TestDrive:\folder\20250131_file1\20250131_file1.txt" | Should -Be "test"
        }
    }
}

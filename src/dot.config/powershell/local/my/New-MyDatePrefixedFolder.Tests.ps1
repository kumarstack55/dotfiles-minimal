BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "New-MyDatePrefixedFolder" {
    It "Makes directory" {
        New-Item -Type Directory -Path "TestDrive:\folder" | Out-Null
        New-Item -Type File -Path "TestDrive:\folder\file1.txt" | Out-Null
        "test" | Set-Content -Path "TestDrive:\folder\file1.txt"

        New-MyDatePrefixedFolder "TestDrive:\folder\file1.txt"

        Test-Path -LiteralPath "TestDrive:\folder\file1.txt" | Should -Be $true
        Get-Content -Path "TestDrive:\folder\file1.txt" | Should -Be "test"
        Test-Path -LiteralPath "TestDrive:\folder\$(Get-Date -Format 'yyyyMMdd')_file1" | Should -Be $true
        Test-Path -LiteralPath "TestDrive:\folder\$(Get-Date -Format 'yyyyMMdd')_file1\file1.txt" | Should -Be $false
    }
}

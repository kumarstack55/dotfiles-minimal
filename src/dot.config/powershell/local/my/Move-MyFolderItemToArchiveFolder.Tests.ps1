BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "Move-MyFolderItemToArchiveFolder" {
    It "Returns expected output" {
        Move-MyFolderItemToArchiveFolder | Should -Be "YOUR_EXPECTED_VALUE"
    }
}

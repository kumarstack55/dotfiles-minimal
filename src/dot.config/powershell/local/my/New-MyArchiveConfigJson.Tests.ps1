BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "New-MyArchiveConfigJson" {
    It "Returns expected output" {
        $ConfigJson = New-MyArchiveConfigJson
        $Config = $ConfigJson | ConvertFrom-Json
        $Config.RootPath | Should -Be '.\Archives'
    }
}

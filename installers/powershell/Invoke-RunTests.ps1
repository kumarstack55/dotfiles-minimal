
$ScriptFolderItem = Get-Item $PSScriptRoot
Set-Location $ScriptFolderItem.Parent.FullName

$TestsDirectoryItem = Get-Item ".\tests"

$ExitStatus = 0

$DslItems = Get-ChildItem -LiteralPath $TestsDirectoryItem.FullName -File -Filter "*.dsl"
foreach ($DslItem in $DslItems) {
    Write-Host ("## test: {0}/{1}" -f $TestsDirectoryItem.Name, $DslItem)

    $ExpectPath = Join-Path $TestsDirectoryItem.FullName ($DslItem.BaseName + ".windows.txt")
    if (-not (Test-Path -LiteralPath $ExpectPath)) {
        $ExpectPath = Join-Path $TestsDirectoryItem.FullName ($DslItem.BaseName + ".txt")
    }
    $Expect = Get-Content -LiteralPath $ExpectPath

    $ScriptPath = $DslItem.FullName
    $Actual = .\powershell\Invoke-Installer.ps1 -ScriptPath $ScriptPath -EnvironmentVariables @{"TEST_DUMMY_KEY"="test_dummy_value"} -WhatIf 6>&1

    $Compare = Compare-Object $Actual $Expect

    if (($null -ne $Compare) -and ($Compare.Count -gt 0)) {
        Write-Host "------------------------------------------------------------"
        Write-Host "Expect: "
        $Expect | Write-Host

        Write-Host "------------------------------------------------------------"
        Write-Host "Actual: "
        $Actual | Write-Host

        $ExitStatus = 1
    } else {
        Write-Host "ok"
    }
    Write-Host ""
}

$ExitStatus

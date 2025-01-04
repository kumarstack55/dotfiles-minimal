$MyDirectoryPath = Join-Path $PSScriptRoot "my"
$ScriptItems = Get-ChildItem -Path $MyDirectoryPath -Filter "*.ps1"
foreach ($ScriptItem in $ScriptItems) {
    $ScriptName = $ScriptItem.Name
    if ($ScriptName -match "\.Tests\.ps1$") {
        continue
    }
    . $ScriptItem.FullName
}

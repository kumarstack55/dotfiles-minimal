. (Join-Path $PSScriptRoot "classes.ps1")

function New-MyArchiveConfigJson {
<#
.SYNOPSIS
アーカイブ設定ファイルを作成します。

.DESCRIPTION
アーカイブ設定ファイルを作成します。

.EXAMPLE
New-MyArchiveConfigJson
#>
    [CmdletBinding()]
    param ()

    $Config = [pscustomobject]@{"RootPath" = [MyArchiveConfigFactory]::DEFAULT_ROOT_PATH}
    $ConfigJson = $Config | ConvertTo-Json
    $ConfigJson
}

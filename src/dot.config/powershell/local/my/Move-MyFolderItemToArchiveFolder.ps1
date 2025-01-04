. (Join-Path $PSScriptRoot "classes.ps1")

function Move-MyFolderItemToArchiveFolder {
<#
.SYNOPSIS
指定したフォルダをアーカイブフォルダに移動します。

.DESCRIPTION
指定したフォルダをアーカイブフォルダに移動します。

.PARAMETER LiteralSourcePathList
LiteralSourcePathList

.PARAMETER LiteralSourcePath
LiteralSourcePath

.EXAMPLE
Move-MyItemToArchiveFolder -LiteralSourcePathList @("C:\path1", "C:\path2") -WhatIf

.EXAMPLE
Move-MyItemToArchiveFolder -LiteralSourcePath "C:\path1" -WhatIf
#>
    [CmdletBinding(
        DefaultParameterSetName="psPathList",
        SupportsShouldProcess=$true
    )]
    param (
        [Parameter(Position=0, ParameterSetName="psPathList", Mandatory, ValueFromPipeline=$true)]
        [string[]]$LiteralSourcePathList,

        [Parameter(Position=1, ParameterSetName="psPath", Mandatory)]
        [string]$LiteralSourcePath
    )

    process {
        if ($LiteralSourcePathList.Count -eq 0) {
            $LiteralSourcePathList = @($LiteralSourcePath)
        }
        $factory = [MyArchiverFactory]::new()
        foreach ($p in $LiteralSourcePathList) {
            # SupportsShouldProcess 有効で、 ShouldProcess() を呼び出さない場合に警告が表示されることを抑止する。
            $PSCmdlet.ShouldProcess($p, $MyInvocation.MyCommand.Name) | Out-Null

            try {
                $a = $factory.Create($p)
                $a.MakeArchiveRootFolder()
                $a.MakeYearFolder()
                $a.Archive()
            } catch {
                Write-Error $_.Exception.Message
            }
        }
    }
}


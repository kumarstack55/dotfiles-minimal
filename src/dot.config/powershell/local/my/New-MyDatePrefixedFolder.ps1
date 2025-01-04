. (Join-Path $PSScriptRoot "classes.ps1")

function New-MyDatePrefixedFolder {
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
        $factory = [MyDatePrefixedFolderMakerFactory]::new()
        foreach ($p in $LiteralSourcePathList) {
            # SupportsShouldProcess 有効で、 ShouldProcess() を呼び出さない場合に警告が表示されることを抑止する。
            $PSCmdlet.ShouldProcess($p, $MyInvocation.MyCommand.Name) | Out-Null
            try {
                $m = $factory.Create($p, $false)
                $m.MakeFolder()
            } catch {
                Write-Error $_.Exception.Message
            }
        }
    }
}

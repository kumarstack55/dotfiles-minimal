$script:DotfilePrompt = 0

function Invoke-DotfilesSwitchPrompt {
    <#
        .SYNOPSIS
        プロンプトを切り替えます。
    #>
    $script:DotfilePrompt = ($script:DotfilePrompt + 1) % 2
}

function Prompt {
    switch ($script:DotfilePrompt) {
        1 {
            # パスに関する情報を出力しないプロンプト定義です。
            "PS $('>' * ($nestedPromptLevel + 1)) "
        }
        default {
            # 既定のプロンプト定義です。
            # (Get-Command prompt).Definition で得たコードを再定義しています。
            "PS $($executionContext.SessionState.Path.CurrentLocation)$('>' * ($nestedPromptLevel + 1)) "
        }
    }
}

function Set-MyPromptSwitch {
    Write-Warning "Deprecated. Use Invoke-DotfilesSwitchPrompt instead."
    Invoke-DotfilesSwitchPrompt
}

# 既定では、タブキーでの補完は完全なコマンドを出力する。
# bash のように、タブキーでの補完をコマンド候補内の共通文字列の最大長の文字列にする。
Set-PSReadlineKeyHandler -Key Tab -Function Complete

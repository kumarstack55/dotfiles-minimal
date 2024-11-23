$script:DotfilesPrompt = 0

# "${HOME}\.config\powershell\local\*.ps1 があれば、読み込む。
if (Test-Path -Type Container "${HOME}\.config\powershell\local") {
    $LocalScriptItems = Get-ChildItem -Path "${HOME}\.config\powershell\local\*.ps1"
    foreach ($LocalScriptItem in $LocalScriptItems) {
        # この処理は、グローバル・スコープで実行する必要がある。
        # 理由は、関数 f1 内で dot-source で関数群を定義したのち、
        # f1 から return すると、関数群の定義が無効になるため。
        . $LocalScriptItem.FullName
    }
}

function Invoke-DotfilesSwitchPrompt {
    <#
        .SYNOPSIS
        プロンプトを切り替えます。
    #>
    $script:DotfilesPrompt = ($script:DotfilesPrompt + 1) % 2
}

function Prompt {
    switch ($script:DotfilesPrompt) {
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

function Invoke-DotfilesMain {
    # "${HOME}\.config\powershell\env.ps1 があれば、移動するよう警告する。
    if (Test-Path "${HOME}\.config\powershell\env.ps1") {
        Write-Warning "Deprecated. Please move ${HOME}\.config\powershell\env.ps1 to ${HOME}\.config\powershell\local\env.ps1"
    }

    # 既定では、タブキーでの補完は完全なコマンドを出力する。
    # bash のように、タブキーでの補完をコマンド候補内の共通文字列の最大長の文字列にする。
    Set-PSReadlineKeyHandler -Key Tab -Function Complete
}

Invoke-DotfilesMain

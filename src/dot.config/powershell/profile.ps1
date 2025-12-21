& {
    $DotfilesPromptVariable = Get-Variable -Name DotfilesPrompt -Scope Script -ErrorAction SilentlyContinue
    if ($null -eq $DotfilesPromptVariable) {
        $Script:DotfilesPrompt = 1
    }
}

# PowerShell で、関数内で関数定義を行うと、関数からreturnしたのち定義が無効になるように見えます。
# 例えば `function f1 { function f2 {} }` を実行後に `f2` は未定義です。
# そのため、関数定義を伴う処理はグローバル・スコープで行う必要があります。

# この処理は関数定義を含むため、グローバル・スコープで行います。
# Gitコマンドのエイリアスを設定します。
if (Get-Command git.exe -ErrorAction SilentlyContinue) {
    function Invoke-MyGitStatus { git status }
    Set-Alias gstatus Invoke-MyGitStatus

    function Invoke-MyGitAddDot { git add . }
    Set-Alias gadd Invoke-MyGitAddDot

    function Invoke-MyGitCommitFix{ git commit -m fix }
    Set-Alias gcfix Invoke-MyGitCommitFix

    function Invoke-MyGitPush{ git push }
    Set-Alias gpush Invoke-MyGitPush
}

# この処理は関数定義を含むため、グローバル・スコープで行います。
# "${HOME}\.config\powershell\local\*.ps1 があれば、読み込む。
if (Test-Path -Type Container "${HOME}\.config\powershell\local") {
    $LocalScriptItems = Get-ChildItem -Path "${HOME}\.config\powershell\local\*.ps1"
    foreach ($LocalScriptItem in $LocalScriptItems) {
        . $LocalScriptItem.FullName
    }
}

function Invoke-DotfilesPromptSwitch {
    <#
        .SYNOPSIS
        プロンプトを切り替えます。
    #>
    $DotfilesPromptMax = 2

    $Script:DotfilesPrompt += 1
    $Script:DotfilesPrompt %= $DotfilesPromptMax + 1

    Write-Host "DotfilesPrompt: $Script:DotfilesPrompt / $DotfilesPromptMax"
}

function Invoke-DotfilesSwitchPrompt {
    Write-Warning "Deprecated. Use Invoke-DotfilesPromptSwitch instead."
    Invoke-DotfilesPromptSwitch
}

function Prompt {
    switch ($Script:DotfilesPrompt) {
        1 {
            # パスに関する情報を親ディレクトリのみ出力するプロンプト定義です。
            "PS $(Split-Path $ExecutionContext.SessionState.Path.CurrentLocation -Leaf)$('>' * ($NestedPromptLevel + 1)) "
        }
        2 {
            # パスに関する情報を出力しないプロンプト定義です。
            "PS $('>' * ($NestedPromptLevel + 1)) "
        }
        default {
            # 既定のプロンプト定義です。
            # (Get-Command prompt).Definition で得たコードを再定義しています。
            "PS $($ExecutionContext.SessionState.Path.CurrentLocation)$('>' * ($NestedPromptLevel + 1)) "
        }
    }
}

function Set-MyPromptSwitch {
    Write-Warning "Deprecated. Use Invoke-DotfilesSwitchPrompt instead."
    Invoke-DotfilesPromptSwitch
}

function Invoke-DotfilesMain {
    # 古い設定ファイルがあれば新しいパスに移動するよう促す。
    $ActionMove = "actionMove"
    $ActionEditAndReplace = "actionEditAndReplace"
    $DeprecatedPathRecords = @(
        @{
            Action = $ActionMove
            OldPath = "${HOME}\.config\powershell\env.ps1"
            NewPath = "${HOME}\.config\powershell\local\env.ps1"
        },
        @{
            Action = $ActionMove
            OldPath = "${HOME}\.gitconfig_generic.inc"
            NewPath = "${HOME}\.config\git\config.inc"
        },
        @{
            Action = $ActionMove
            OldPath = "${HOME}\vimfiles\local.vim"
            NewPath = "${HOME}\.config\vim\local\pre-addons.vim"
        },
        @{
            Action = $ActionMove
            OldPath = "${HOME}\vimfiles\local"
            NewPath = "${HOME}\.config\vim\local"
        },
        @{
            Action = $ActionEditAndReplace
            OldPath = "${HOME}\.textlintrc.json"
            NewPath = "${HOME}\.textlintrc.yml"
        }
    )
    foreach ($r in $DeprecatedPathRecords) {
        if ($r.Action -eq $ActionMove) {
            if (Test-Path $r.OldPath) {
                Write-Warning "Deprecated. Please move $($r.OldPath) to $($r.NewPath)"
            }
        } elseif ($r.Action -eq $ActionEditAndReplace) {
            if (Test-Path $r.OldPath) {
                Write-Warning "Deprecated. Please edit $($r.OldPath) and replace $($r.NewPath)"
            }
        } else {
            Write-Warning "Unknown action."
        }
    }

    # 既定では、タブキーでの補完は完全なコマンドを出力する。
    # bash のように、タブキーでの補完をコマンド候補内の共通文字列の最大長の文字列にする。
    Set-PSReadlineKeyHandler -Key Tab -Function Complete
}

function Export-DotfilesGitUserProfiles {
    param(
        [Parameter(Mandatory)]
        [string]
        $Path,

        [Parameter(Mandatory)]
        [Object[]]
        $Records
    )
    $recordsAsArray = ,$Records
    $jsonTextNotPretty = $recordsAsArray | ConvertTo-Json -Depth 100
    if (Get-Command jq) {
        $jsonText = $jsonTextNotPretty | jq .
    } else {
        $jsonText = $jsonTextNotPretty
    }
    $jsonText | Set-Content -LiteralPath $Path -Encoding UTF8
}

function Import-DotfilesGitUserProfiles {
    param(
        [Parameter(Mandatory)]
        [string]
        $Path
    )
    $jsonText = Get-Content -LiteralPath $Path
    $recordsAsArray = $jsonText | ConvertFrom-Json
    $records = $recordsAsArray.value
    $records
}

function Invoke-DotfilesConfigureGitConfigUserByProfile {
    param(
        [Parameter()]
        [string]
        $ProfileName = ""
    )
    $path = "$HOME\.config\git\local\user-profiles.json"

    # ファイルを読む。
    if (-not (Test-Path -LiteralPath $path)) {
        Write-Host "file not found: $path"
        return
    }
    $userProfiles = @(Import-DotfilesGitUserProfiles -Path $path)

    # プロファイルが指定されてなかったら指定を促す。
    if ($ProfileName -eq "") {
        Write-Host "select profile."
        $userProfiles
        return
    }

    # ディレクトリがgit管理下か確認する。
    git rev-parse --is-inside-work-tree
    if (-not $?) {
        return
    }

    # プロファイルの設定を行う。
    $found = $false
    foreach ($p in $userProfiles) {
        if ($p.name -eq $ProfileName) {
            git config user.email $p.userEmail
            git config user.name $p.userName
            Write-Host "You may want to run following commands:" -ForegroundColor Yellow
            Write-Host "  git config credential.https://github.com.username $($p.userName)"
            $found = $true
            break
        }
    }
    if (-not $found) {
        Write-Host "profile not found: $ProfileName"
        return
    }
}

& {
    $userProfileSamplePath = "$HOME\.config\git\local\user-profiles.json.sample"
    $userProfilePath = "$HOME\.config\git\local\user-profiles.json"
    $records = @(
        @{
            "name" = "default"
            "userEmail" = "you@example.com"
            "userName" = "Your Name"
        }
    )
    if (-not (Test-Path $userProfileSamplePath)) {
        Export-DotfilesGitUserProfiles -Records $records -Path $userProfileSamplePath
    }
    if (-not (Test-Path $userProfilePath)) {
        Copy-Item $userProfileSamplePath $userProfilePath
    }
}

Invoke-DotfilesMain

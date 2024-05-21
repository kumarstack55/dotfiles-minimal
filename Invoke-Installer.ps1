[CmdletBinding(SupportsShouldProcess)]
param()

class MyException : Exception {
    MyException($Message) : base($Message) {}
}

class IllegalArgumentException : MyException {
    IllegalArgumentException($Message) : base($Message) {}
}

function Invoke-Skip {
    param([Parameter(Mandatory)][string]$Message)

    Write-Host "skip: $Message"
}

function Invoke-ModuleCopy {
    param(
        [Parameter(Mandatory)][string]$Src,
        [Parameter(Mandatory)][string]$Dest
    )

    if (-not (Test-Path -LiteralPath $Dest)) {
        Copy-Item -LiteralPath $Src -Destination $Dest
    } else {
        Invoke-Skip "copy ${Src} ${Dest}"
    }
}

function Invoke-ModuleCopyWin {
    param(
        [Parameter(Mandatory)][string]$Src,
        [Parameter(Mandatory)][string]$Dest
    )
    Invoke-ModuleCopy -Src $Src -Dest $Dest
}

function Invoke-ModuleMkdirWin {
    param(
        [Parameter(Mandatory)][string]$Path
    )
    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -Type Directory -Path $Path
    } else {
        Invoke-Skip "mkdir_win ${Path}"
    }
}

function Invoke-ParseLine {
    param([Parameter(Mandatory)][string]$Line)

    $WordsArray = $Line -split "\s+"
    $WordsList = [System.Collections.Generic.List[string]]::new($WordsArray)

    foreach ($Index in 0..($WordsList.Count-1)) {
        $Word = $WordsList[$Index]
        $WordsList[$Index] = $Word -replace '\${HOME}', $env:USERPROFILE
    }

    $Module = $WordsList[0]
    $WordsList.RemoveAt(0)
    switch -Exact ($Module) {
        "copy" { Invoke-ModuleCopy @WordsList }
        "copy_win" { Invoke-ModuleCopyWin @WordsList }
        "mkdir_win" { Invoke-ModuleMkdirWin @WordsList }
        default {
            throw [IllegalArgumentException]::new("unknown module: ${Module}")
        }
    }
}

function Invoke-ParsePlaybook {
    param([Parameter(Mandatory)][string]$PlaybookPath)

    $PlaybookContent = Get-Content -Path $PlaybookPath
    $PlaybookContent | ForEach-Object {
        $Line = $_
        if ($Line -match '^#|^\s*$') {
            continue
        }
        Invoke-ParseLine $Line
    }
}

function Invoke-Main {
    $PlaybookPath = Join-Path $PSScriptRoot "playbook.dsl"

    Set-Location $PSScriptRoot
    Invoke-ParsePlaybook $PlaybookPath
}

Invoke-Main
# vim:ts=4 sw=4 sts=4 et:

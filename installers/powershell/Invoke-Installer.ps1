﻿[CmdletBinding(SupportsShouldProcess)]
param([string]$ScriptPath, [hashtable]$EnvironmentVariables)

$script:Env = [hashtable]::new()

class AppException : Exception {
    AppException([string]$Message) : base($Message) {}
}

class IllegalArgumentException : AppException {
    IllegalArgumentException([string]$Message) : base($Message) {}
}

class SyntaxErrorException : IllegalArgumentException {
    SyntaxErrorException() : base() {}
    SyntaxErrorException([string]$Message) : base($Message) {}
}

class UnexpectedEndOfFileException : SyntaxErrorException {
    UnexpectedEndOfFileException() : base() {}
    UnexpectedEndOfFileException([string]$Message) : base($Message) {}
}

class InternalErrorException: AppException {
    InternalErrorException() : base() {}
    InternalErrorException([string]$Message) : base($Message) {}
}

class Command {
    WriteSkip() {
        Write-Host "skip."
    }
    Run([System.Collections.Generic.List[string]]$Stack) {
        throw
    }
}

function Test-ShouldProcess {
    param([Parameter(Mandatory)][string]$Message)

    if ($WhatIfPreference) {
        Write-Host "should_process: $Message"
    }
    return -not $WhatIfPreference
}

class CommandNoOperation : Command {
    Run([System.Collections.Generic.List[string]]$Stack) {
        $CommandArgs = $Stack -join " "
        if (Test-ShouldProcess($CommandArgs)) {
            $this.WriteSkip()
        }
    }
}

class CommandCopy : Command {
    Run([System.Collections.Generic.List[string]]$Stack) {
        $Command, $Source, $Destination, $_ = $Stack
        if (Test-ShouldProcess("${Command} ${Source} ${Destination}")) {
            if (Test-Path -LiteralPath $Destination) {
                $this.WriteSkip()
                return
            }
            Copy-Item -LiteralPath $Source -Destination $Destination -Verbose
        }
    }
}

class CommandMkdir : Command {
    Run([System.Collections.Generic.List[string]]$Stack) {
        $Command, $Path, $_ = $Stack
        if (Test-ShouldProcess("${Command} ${Path}")) {
            if (Test-Path -LiteralPath $Path) {
                $this.WriteSkip()
                return
            }
            New-Item -Type Directory -Path $Path -Verbose
        }
    }
}

class CommandFactory {
    [hashtable]$NameToClass
    CommandFactory() {
        $this.NameToClass = [hashtable]::new()
    }
    Add([string]$Key, $Class) {
        $this.NameToClass[$Key] = $Class
    }
    [bool]ContainsKey([string]$Key) {
        return $this.NameToClass.ContainsKey($Key)
    }
    [Command]CreateCommand([string]$FunctionName) {
        $Class = $this.NameToClass[$FunctionName]
        $Command = $Class::new()
        return $Command
    }
    static [CommandFactory]Create() {
        $f = [CommandFactory]::new()
        $f.Add("copy", [CommandCopy])
        $f.Add("copy_win", [CommandCopy])
        $f.Add("copy_linux", [CommandNoOperation])
        $f.Add("mkdir_win", [CommandMkdir])
        $f.Add("mkdir_linux", [CommandNoOperation])
        return $f
    }
}

class Parser {
    [LineReader]$Reader
    [CommandFactory]$CommandFactory
    [System.Collections.Generic.List[string]]$Stack
    [string]$StringBuffer
    Parser([LineReader]$Reader, [CommandFactory]$CommandFactory) {
        $this.Stack = [System.Collections.Generic.List[string]]::new()
        $this.StringBuffer = $null

        $this.Reader = $Reader
        $this.CommandFactory = $CommandFactory
    }
    [bool]IsSpace() {
        return $this.Reader.ReadChar() -eq ' '
    }
    [bool]IsFunctionCharacter() {
        return $this.Reader.ReadChar() -match '^[a-zA-Z0-9_$]$'
    }
    SkipWs0() {
        while ($this.Reader.IsNotEof()) {
            if (-not $this.IsSpace()) {
                break
            }
            $this.Reader.ReadNext()
        }
    }
    SkipWs1() {
        if ($this.IsSpace()) {
            $this.SkipWs0()
        } else {
            throw [SyntaxErrorException]::new("blank space required")
        }
    }
    ParseComment() {
        while ($this.Reader.IsNotEof()) {
            $this.Reader.ReadNext()
        }
    }
    ParseFunction() {
        $Name = ""

        while ($this.Reader.IsNotEof()) {
            if ($this.IsFunctionCharacter()) {
                $Name += $this.Reader.ReadChar()
                $this.Reader.ReadNext()
            } else {
                if ($Name -eq "") {
                    throw [SyntaxErrorException]::new("Function name is zero-length string")
                }
                $this.Stack.Add($Name)
                return
            }
        }

        if ($Name -eq "") {
            throw [SyntaxErrorException]::new("Function name is zero-length string")
        }
        $this.Stack.Add($Name)
    }
    ParseEscape() {
        if ($this.Reader.ReadChar() -ne "\") {
            throw [InternalErrorException]::new()
        }

        $this.Reader.ReadNext()
        if ($this.Reader.IsEof()) {
            throw [UnexpectedEndOfFileException]::new()
        }

        switch -Exact ($this.Reader.ReadChar()) {
            '"' { $this.StringBuffer += '"' }
            '\' { $this.StringBuffer += '\' }
            '$' { $this.StringBuffer += '$' }
            default {
                $Message = "Invalid escape [{0}]" -f $this.Reader.ReadChar()
                throw [SyntaxErrorException]::new($Message)
            }
        }
        $this.Reader.ReadNext()
    }
    ParseVariable() {
        $Name = ""

        if ($this.Reader.ReadChar() -ne '$') {
            throw [InternalErrorException]::new()
        }

        $this.Reader.ReadNext()
        if ($this.Reader.IsEof()) {
            throw [UnexpectedEndOfFileException]::new()
        }

        if ($this.Reader.ReadChar() -ne '{') {
            throw [SyntaxErrorException]::new("Character [{] does not exist")
        }

        $this.Reader.ReadNext()
        while ($this.Reader.IsNotEof()) {
            if ($this.Reader.ReadChar() -eq '}') {
                $this.Reader.ReadNext()

                if (-not ($script:Env.ContainsKey($Name))) {
                    throw [SyntaxErrorException]::new("Unknown variable name: [$Name]")
                }
                $this.StringBuffer += $script:Env[$Name]
                return
            } else {
                $Name += $this.Reader.ReadChar()
                $this.Reader.ReadNext()
            }
        }

        throw [UnexpectedEndOfFileException]::new()
    }
    ParseStringCharacters() {
        while ($this.Reader.IsNotEof()) {
            switch ($this.Reader.ReadChar()) {
                '"' { return }
                '\' { $this.ParseEscape() }
                '$' { $this.ParseVariable() }
                default {
                    $this.StringBuffer += $this.Reader.ReadChar()
                    $this.Reader.ReadNext()
                }
            }
        }

        throw [UnexpectedEndOfFileException]::new()
    }
    ParseString() {
        if ($this.Reader.ReadChar() -ne '"') {
            [InternalErrorException]::new()
        }

        $this.Reader.ReadNext()
        if ($this.Reader.IsEof()) {
            [UnexpectedEndOfFileException]::new()
        }

        $this.StringBuffer = ''
        $this.ParseStringCharacters()
        if ($this.Reader.ReadChar() -ne '"') {
            [SyntaxErrorException]::new()
        }

        $this.Reader.ReadNext()

        $this.Stack.Add($this.StringBuffer)
    }
    ParseArgument() {
        $this.ParseString()
    }
    ParseArguments() {
        $this.ParseArgument()
        if ($this.Reader.IsEof()) {
            return
        }

        $this.SkipWS1()
        if ($this.Reader.IsEof()) {
            return
        }

        $this.ParseArguments()
    }
    ParseCommand() {
        $this.ParseFunction()

        $FunctionName = $this.Stack[0]
        if (-not ($this.CommandFactory.ContainsKey($FunctionName))) {
            throw [SyntaxErrorException]::new("Unknown function: [$FunctionName]")
        }

        if ($this.Reader.IsNotEof()) {
            $this.SkipWs1()
            if ($this.Reader.IsNotEof()) {
                $this.ParseArguments()
            }
        }

        $Command = $this.CommandFactory.CreateCommand($FunctionName)
        Write-Host ("run: " + ($this.Stack -join ' '))
        $Command.Run($this.Stack)
    }
    ParseLine() {
        if ($this.Reader.IsEof()) {
            return
        }

        switch ($this.Reader.ReadChar()) {
            '#' { $this.ParseComment() }
            default { $this.ParseCommand() }
        }
    }
    ParseProgram() {
        $this.SkipWs0()
        $this.ParseLine()
        $this.SkipWs0()
    }
}

function Main {
    Get-Content -Path $script_path | ForEach-Object {
        $line = $_ -replace "\r", ""
        Write-Host "---"
        Reader-Init $line
        Write-Host "line: [$line]"
        Parser-Init
        Parser-Parse-Program
    }
}

function Initialize-EnvironmentVariables {
    $script:Env["HOME"] = $HOME
    $script:Env["PROFILE"] = $PROFILE
}

class LineReader {
    [string]$Line
    [int]$Position
    [char]$Char
    [bool]$Eof

    LineReader([string]$Line) {
        $this.Line = $Line
        $this.Position = -1
        $this.Char = $null
        $this.Eof = $false
    }
    [bool]IsEof() {
        return $this.Eof
    }
    [bool]IsNotEof() {
        return -not $this.IsEof()
    }
    ReadNext() {
        if ($this.IsNotEof()) {
            $this.Position += 1
            if ($this.Position -lt $this.Line.Length) {
                $this.Char = $this.Line[$this.Position]
            } else {
                $this.Char = $null
                $this.Eof = $true
            }
        }
    }
    [char]ReadChar() {
        return $this.Char
    }
    PrintSyntaxError() {
        Write-Host ("Position: {0}" -f $this.Position)
        Write-Host ("input: [{0}]" -f $this.Line)
        Write-Host ("        {0}^" -f (" " * $this.Position))
    }
}

function Invoke-Installer {
    param(
        [Parameter(Mandatory)][string]$ScriptPath,
        [hashtable]$EnvironmentVariables
    )

    Initialize-EnvironmentVariables
    if ($EnvironmentVariables) {
        foreach ($Key in $EnvironmentVariables.Keys) {
            $Value = $EnvironmentVariables[$Key]
            $script:Env[$Key] = $Value
        }
    }

    $Lines = Get-Content -LiteralPath $ScriptPath
    foreach ($Line in $Lines) {
        # TODO: $line = $_ -replace "\r", ""
        Write-Host "---"
        Write-Host "line: [$Line]"

        $Reader = [LineReader]::new($Line)
        $CommandFactory = [CommandFactory]::Create()
        $Parser = [Parser]::new($Reader, $CommandFactory)

        $Reader.ReadNext()

        $Parser.ParseProgram()
    }
}

if ($MyInvocation.InvocationName -ne '.') {
    Invoke-Installer -EnvironmentVariables $EnvironmentVariables -ScriptPath $ScriptPath
}

﻿if ($MyClassesLoaded) {
    return
}
$MyClassesLoaded = $true

class MyException : Exception {
    MyException([string]$Message) : base($Message) {}
}

class MyArchiveConfig {
    [string] $RootPath
    MyArchiveConfig([string]$RootPath) {
        $this.RootPath = $RootPath
    }
}

class MyArchiveConfigFactory {
    static [string] $DEFAULT_ROOT_PATH = '.\Archives'

    static [MyArchiveConfig] Create([PSCustomObject]$ConfigPso) {
        $RootPath = $ConfigPso.RootPath
        if ($null -eq $RootPath) {
            $RootPath = [MyArchiveConfigFactory]::DEFAULT_ROOT_PATH
        }
        return [MyArchiveConfig]::new($RootPath)
    }
}

class MyArchiver {
    [string] $SourcePath
    [string] $ArchiveJsonPath
    [MyArchiveConfig] $ArchiveConfig
    [string] $ArchiveRootPath
    [string] $YearFolderPath
    [string] $DestinationPath

    MyArchiver([string]$SourcePath, [string]$ArchiveJsonPath, [MyArchiveConfig]$ArchiveConfig, [string]$ArchiveRootPath, [string]$YearFolderPath, [string]$DestinationPath) {
        $this.SourcePath = $SourcePath
        $this.ArchiveJsonPath = $ArchiveJsonPath
        $this.ArchiveConfig = $ArchiveConfig
        $this.ArchiveRootPath = $ArchiveRootPath
        $this.YearFolderPath = $YearFolderPath
        $this.DestinationPath = $DestinationPath
    }

    MakeArchiveRootFolder() {
        if (-not (Test-Path -LiteralPath $this.ArchiveRootPath)) {
            New-Item -ItemType Directory -Path $this.ArchiveRootPath -ErrorAction Stop | Out-Null
        }
    }

    MakeYearFolder() {
        if (-not (Test-Path -LiteralPath $this.YearFolderPath)) {
            New-Item -ItemType Directory -Path $this.YearFolderPath -ErrorAction Stop | Out-Null
        }
    }

    Archive() {
        Move-Item -LiteralPath $this.SourcePath -Destination $this.DestinationPath
    }
}

class MyArchiverFactory {
    static [string] $ArchiveConfigJsonName = ".archiveconfig.json"

    hidden [DateTime] GetDateFromPath([string]$Path) {
        $Name = Split-Path -Leaf $Path

        $DatePatterns = @(
            "^\d{4}\d{2}\d{2}"
        )

        $Found = $false
        foreach ($DatePattern in $DatePatterns) {
            if ($Name -match $DatePattern) {
                $Found = $true
                break
            }
        }
        if (-not $Found) {
            $Message = "DatePattern not found. Folder names must begin with an 8-digit number representing the date. (Path: {0})" -f $Path
            throw [MyException]::new($Message)
        }

        $ParsedDate = [DateTime]::MinValue;
        $String = $Matches[0]
        $Format = "yyyyMMdd"
        $Provider = $null
        $Style = [System.Globalization.DateTimeStyles]::None
        if (-not [DateTime]::TryParseExact($String, $Format, $Provider, $Style, [ref]$ParsedDate)) {
            $Message = "TryParseExact() failed. (Path: {0})" -f $Path
            throw [MyException]::new($Message)
        }
        return $ParsedDate
    }

    hidden TestItemCanBeArchived([string]$SourcePath) {
        if (-not (Test-Path -LiteralPath $SourcePath)) {
            $Message = "SourcePath is not exist. (SourcePath: {0})" -f $SourcePath
            throw [MyException]::new($Message)
        }

        $SourceItem = Get-Item -LiteralPath $SourcePath
        if ($SourceItem.Name -eq [MyArchiverFactory]::ArchiveConfigJsonName) {
            $Message = "SourcePath is ArchiveConfigJson. (SourcePath: {0})" -f $SourcePath
            throw [MyException]::new($Message)
        }
        if ($SourceItem.PSIsContainer) {
            $Items = Get-ChildItem -LiteralPath $SourceItem.FullName -Recurse -Filter [MyArchiverFactory]::ArchiveConfigJsonName
            if ($Items.Count -gt 0) {
                $ArchiveJsonPathArray = $Items | ForEach-Object { $_.FullName }
                $Message = "SourcePath contains ArchiveConfigJson. ({0})" -f $ArchiveJsonPathArray
                throw [MyException]::new($Message)
            }
        }

        if ($SourcePath.Name -match '^\d{4}') {
            $Message = "SourcePath is year folder? (SourcePath: {0})" -f $SourcePath
            throw [MyException]::new($Message)
        }

    }

    hidden [string]GetArchiveConfigJsonPath([string]$SourcePath) {
        $Item = Get-Item -LiteralPath $SourcePath
        while ($null -ne $Item) {
            $Name = [MyArchiverFactory]::ArchiveConfigJsonName
            $ArchiveJsonPath = Join-Path $Item.FullName $Name
            if (Test-Path -LiteralPath $ArchiveJsonPath) {
                return $ArchiveJsonPath
            }
            $Item = $Item.Parent
        }

        $Message = "ArchiveConfigJson is not found. (SourcePath: {0})" -f $SourcePath
        throw [MyException]::new($Message)
    }

    hidden [MyArchiveConfig]GetArchiveConfig([string]$ArchiveConfigJsonPath) {
        $ConfigJsonContent = Get-Content -LiteralPath $ArchiveConfigJsonPath -Encoding UTF8
        $ConfigPso = $ConfigJsonContent | ConvertFrom-Json
        [MyArchiveConfig] $ArchiveConfig = [MyArchiveConfigFactory]::Create($ConfigPso)
        return $ArchiveConfig
    }

    hidden [string]GetArchiveRootPath([string]$ArchiveConfigJsonDirectoryPath, [MyArchiveConfig]$Config) {
        if ($Config.RootPath -match '^\.\\') {
            $RootPath = $Config.RootPath.Substring(2)
            $ArchiveRootPath = Join-Path $ArchiveConfigJsonDirectoryPath $RootPath
        } else {
            $ArchiveRootPath = $Config.RootPath
        }
        return $ArchiveRootPath
    }

    [MyArchiver] Create([string]$SourcePath) {
        $Name = Split-Path -Leaf $SourcePath

        $Date = $this.GetDateFromPath($SourcePath)
        $this.TestItemCanBeArchived($SourcePath)

        $ArchiveConfigJsonPath = $this.GetArchiveConfigJsonPath($SourcePath)

        $ArchiveConfig = $this.GetArchiveConfig($ArchiveConfigJsonPath)

        $ArchiveConfigJsonDirectoryPath = Split-Path -Parent $ArchiveConfigJsonPath
        $ArchiveRootPath = $this.GetArchiveRootPath($ArchiveConfigJsonDirectoryPath, $ArchiveConfig)

        $YearFolderPath = Join-Path $ArchiveRootPath $Date.ToString("yyyy")

        $DestinationPath = Join-Path $YearFolderPath $Name

        return [MyArchiver]::new($SourcePath, $ArchiveConfigJsonPath, $ArchiveConfig, $ArchiveRootPath, $YearFolderPath, $DestinationPath)
    }
}

class MyDatePrefixedFolderMaker {
    [string] $SourcePath
    [string] $DestinationFolder
    [string] $DestinationPath

    MyDatePrefixedFolderMaker([string]$SourcePath, [string]$DestinationFolder) {
        $this.SourcePath = $SourcePath
        $this.DestinationFolder = $DestinationFolder
        $this.DestinationPath = $null
    }
    MyDatePrefixedFolderMaker([string]$SourcePath, [string]$DestinationFolder, [string]$DestinationPath) {
        $this.SourcePath = $SourcePath
        $this.DestinationFolder = $DestinationFolder
        $this.DestinationPath = $DestinationPath
    }
    MakeFolder() {
        if (-not (Test-Path -LiteralPath $this.DestinationFolder)) {
            New-Item -ItemType Directory -Path $this.DestinationFolder -ErrorAction Stop | Out-Null
        }
    }
    MoveToDestination() {
        if ($null -eq $this.DestinationPath) {
            $Message = "DestinationPath is null. (DestinationPath: {0})" -f $this.DestinationPath
            throw [MyException]::new($Message)
        }
        if (Test-Path -LiteralPath $this.DestinationPath) {
            $Message = "DestinationPath already exists. (DestinationPath: {0})" -f $this.DestinationPath
            throw [MyException]::new($Message)
        }
        Move-Item -LiteralPath $this.SourcePath -Destination $this.DestinationPath
    }
}

class MyDatePrefixedFolderMakerFactory {
    hidden [DateTime] GetDateFromPath([string]$Path) {
        $Name = Split-Path -Leaf $Path

        $DatePatterns = @(
            "^\d{4}\d{2}\d{2}"
        )

        $Found = $false
        foreach ($DatePattern in $DatePatterns) {
            if ($Name -match $DatePattern) {
                $Found = $true
                break
            }
        }
        if (-not $Found) {
            $Message = "DatePattern not found. (Path: {0})" -f $Path
            throw [MyException]::new($Message)
        }

        $ParsedDate = [DateTime]::MinValue;
        $String = $Matches[0]
        $Format = "yyyyMMdd"
        $Provider = $null
        $Style = [System.Globalization.DateTimeStyles]::None
        if (-not [DateTime]::TryParseExact($String, $Format, $Provider, $Style, [ref]$ParsedDate)) {
            $Message = "TryParseExact failed. (Path: {0})" -f $Path
            throw [MyException]::new($Message)
        }
        return $ParsedDate
    }

    hidden [string] GetDestinationFolder([string]$SourcePath) {
        $ParentDirectoryPath = Split-Path -Parent $SourcePath
        if ($ParentDirectoryPath -eq "") {
            $ParentDirectoryPath = "."
        }

        $OriginalNameWithExtension = Split-Path -Leaf $SourcePath
        $OriginalName = [System.IO.Path]::GetFileNameWithoutExtension($OriginalNameWithExtension)
        try {
            $this.GetDateFromPath($SourcePath) | Out-Null
            $Name = $OriginalName
        } catch {
            $Date = Get-Date
            $Prefix = Get-Date -Date $Date -Format "yyyyMMdd"
            $Name = "{0}_{1}" -f $Prefix, $OriginalName
        }

        $DestinationFolder = Join-Path $ParentDirectoryPath $Name
        return $DestinationFolder
    }

    [MyDatePrefixedFolderMaker] Create([string]$SourcePath, [bool]$SourcePathExists) {
        $DestinationFolder = $this.GetDestinationFolder($SourcePath)

        $Name = Split-Path -Leaf $SourcePath

        # SourcePathExists が true なら、移動できるようにする。
        if ($SourcePathExists) {
            $DestinationPath = Join-Path $DestinationFolder $Name
            return [MyDatePrefixedFolderMaker]::new($SourcePath, $DestinationFolder, $DestinationPath)
        }

        # 移動できないようにする。
        return [MyDatePrefixedFolderMaker]::new($SourcePath, $DestinationFolder)
    }

    [MyDatePrefixedFolderMaker] Create([string]$SourcePath) {
        return $this.Create($SourcePath, $true)
    }
}

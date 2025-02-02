$ConfigDirectoryPath = Join-Path $HOME ".config"
$PowerShellConfigDirectoryPath = Join-Path $ConfigDirectoryPath "powershell"
$MyProfilePath = Join-Path $PowerShellConfigDirectoryPath "profile.ps1"
. $MyProfilePath
Write-Host "Loaded: ${PSCommandPath}"

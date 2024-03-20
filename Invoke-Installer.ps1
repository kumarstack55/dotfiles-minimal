[CmdletBinding(SupportsShouldProcess)]
param()
$gvimrcSourcePath = Join-Path $PSScriptRoot "_gvimrc"
$gvimrcDestinationPath = Join-Path $env:USERPROFILE "_gvimrc"
Copy-Item $gvimrcSourcePath $gvimrcDestinationPath

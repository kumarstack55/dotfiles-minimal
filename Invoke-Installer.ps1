[CmdletBinding(SupportsShouldProcess)]
param()
$gvimrcSourcePath = Join-Path $PSScriptRoot "_gvimrc"
$gvimrcDestinationPath = Join-Path $env:USERPROFILE "_gvimrc"
Copy-Item $gvimrcSourcePath $gvimrcDestinationPath

$vimrcSourcePath = Join-Path $PSScriptRoot "dot.vimrc"
$vimrcDestinationPath = Join-Path $env:USERPROFILE "_vimrc"
Copy-Item $vimrcSourcePath $vimrcDestinationPath

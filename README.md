# dotfiles-minimal

## Principle

- Only configuration is performed.
    - Do not install additional modules from the Internet without user intervention.

## Requirements

- Debian
    - bash 5.2+
    - Vim 9.0+
- Ubuntu
    - bash 5.1+
    - Vim 8.2+
- Microsoft Windows
    - Windows PowerShell 5.1+
    - Vim 9.1+

## Installation

### Debian

```bash
git clone https://github.com/kumarstack55/dotfiles-minimal.git

cd dotfiles-minimal

./installers/bash/install.sh -c ./playbook.dsl
./installers/bash/install.sh -f ./playbook.dsl
```

### Microsoft Windows

```powershell
git clone https://github.com/kumarstack55/dotfiles-minimal.git

Set-Location .\dotfiles-minimal

Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
.\installers\powershell\Invoke-Installer.ps1 -ScriptPath .\playbook.dsl -WhatIf
.\installers\powershell\Invoke-Installer.ps1 -ScriptPath .\playbook.dsl

# The following policy settings are required to load a profile.
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

## TODO

- TODO: add github copilot support

## LICENSE

MIT

# dotfiles-minimal

## Principle

- Only configuration is performed.
    - Do not install additional modules from the Internet without user intervention.

## Requirements

- Linux
    - Debian
        - bash 5.2+
        - Vim 9.0+
        - NeoVim 0.7+
    - Ubuntu
        - bash 5.1+
        - Vim 8.2+
            - If you use github copilot, you need Vim 9.0+.
            - If you use wsl, install npm before you install lsp server.
        - NeoVim 0.6+
            - If you use github copilot, you need NeoVim 0.7+.
            - If you use wsl, install npm before you install lsp server.
- Microsoft Windows
    - Windows PowerShell 5.1+
    - Vim 9.1+
    - NeoVim 0.8+

## Installation

### Linux

```bash
git clone https://github.com/kumarstack55/dotfiles-minimal.git

cd dotfiles-minimal

./installers/bash/install.sh -c ./playbook.dsl
./installers/bash/install.sh -f ./playbook.dsl

./ensure_that_hook_line_exists_in_bashrc.sh
```

If you want to install additional modules, you need to continue reading the additional_modules.md file.

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

- [ ] test lsp on windows
- [ ] simplify installer playbook

## LICENSE

MIT

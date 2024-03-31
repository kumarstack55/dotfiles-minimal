# dotfiles-minimal

## Requirements

- Debian
    - Vim 9.0+
- Microsoft Windows
    - Vim 9.1+

## Installation

### Debian

```bash
git clone https://github.com/kumarstack55/dotfiles-minimal.git

cd dotfiles-minimal

./install.sh
```

### Microsoft Windows

```powershell
git clone https://github.com/kumarstack55/dotfiles-minimal.git

Set-Location .\dotfiles-minimal

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

.\Invoke-Installer.ps1 -WhatIf

.\Invoke-Installer.ps1
```

## LICENSE

MIT

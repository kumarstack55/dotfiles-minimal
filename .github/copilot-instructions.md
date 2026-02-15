# Copilot Instructions for dotfiles-minimal

## Project Overview

This is a cross-platform dotfiles repository that deploys configuration files for Vim/NeoVim, bash, PowerShell, and git. It uses a custom DSL (Domain Specific Language) installer that reads `playbook.dsl` files to copy configuration files to their target locations.

**Key Philosophy**: Only configuration is performed. Do not install add-ons from the Internet without user intervention.

## Architecture

### Custom DSL Installer

The core of this repository is a custom installer that parses `.dsl` files:

- **DSL Operations**: `copy`, `copy_linux`, `copy_win`, `copy_crlf_win`, `mkdir`, `mkdir_linux`, `mkdir_win`, `set`, `set_linux`, `set_win`
- **Platform-specific commands**: Commands with `_linux` suffix run only on Linux; `_win` suffix only on Windows
- **Variable interpolation**: Uses `${VAR_NAME}` syntax for variable substitution
- **Main playbook**: `playbook.dsl` defines all file copy operations

### Installer Implementations

Two parallel implementations process the same DSL:

1. **Bash installer**: `installers/bash/install.sh`
   - Hand-written parser with tokenizer/stack-based execution
   - Check mode (`-c`) for dry-run, force mode (`-f`) for execution
   - Variable overrides via `-e KEY=VALUE`

2. **PowerShell installer**: `installers/powershell/Invoke-Installer.ps1`
   - PowerShell implementation with `SupportsShouldProcess`
   - Uses `-WhatIf` for dry-run, omit for execution
   - Variable overrides via `-EnvironmentVariables @{KEY="VALUE"}`

Both installers must produce identical output for platform-specific test cases.

### Directory Structure

- `src/`: Source configuration files (prefixed with `dot.` representing `.` in home directory)
- `installers/`: Platform-specific installer scripts
- `installers/tests/`: DSL test files (`.dsl`) and expected output (`.txt`, `.linux.txt`, `.windows.txt`)
- `playbook.dsl`: Main installation playbook

## Build, Test, and Lint Commands

### Running Tests

**Linux/Bash:**
```bash
cd installers
./bash/run_tests.sh
```

Tests each `.dsl` file in `installers/tests/` directory, comparing output against expected `.txt` files.

**Windows/PowerShell:**
```powershell
cd installers
.\powershell\Invoke-RunTests.ps1
```

### Testing PowerShell Modules

PowerShell modules use Pester tests (files ending in `.Tests.ps1`):

```powershell
# Run specific test file
Invoke-Pester -Path "src\dot.config\powershell\local\my\*.Tests.ps1"

# Run all Pester tests
Invoke-Pester -Path "src" -Recurse
```

**Test conventions:**
- Each module has a paired test file (e.g., `Module.ps1` → `Module.Tests.ps1`)
- Tests use `BeforeAll { . $PSCommandPath.Replace('.Tests.ps1', '.ps1') }` to source the module
- Use `TestDrive:\` for temporary test files

### Linting

Markdown linting is configured via `.markdownlint.yml` and VS Code settings.

## Installation and Usage

**Linux installation:**
```bash
./installers/bash/install.sh -c ./playbook.dsl  # Check mode (dry-run)
./installers/bash/install.sh -f ./playbook.dsl  # Force mode (execute)
./ensure_that_hook_line_exists_in_bashrc.sh     # Add hook to .bashrc
```

**Windows installation:**
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
.\installers\powershell\Invoke-Installer.ps1 -ScriptPath .\playbook.dsl -WhatIf  # Dry-run
.\installers\powershell\Invoke-Installer.ps1 -ScriptPath .\playbook.dsl          # Execute
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned             # Enable profile loading
```

## Key Conventions

### File Naming

- Source files in `src/` use `dot.` prefix instead of `.` (e.g., `dot.gitconfig` → `~/.gitconfig`)
- Sample files end with `.sample` suffix (user must copy/customize)
- Platform-specific config: `init.vim` (Linux) vs `init_windows.vim` (Windows)

### Variable Substitution in DSL

- `${HOME}`: User's home directory
- `${PROFILE}`: PowerShell profile path (Windows only)
- `${APPDATA}`: Windows AppData roaming directory
- Custom variables: Set via `set`, `set_linux`, `set_win` commands or `-e`/`-EnvironmentVariables`

### Test File Conventions

DSL test files in `installers/tests/`:
- `.dsl`: Test script
- `.txt`: Expected output for both platforms
- `.linux.txt`: Expected output for Linux only
- `.windows.txt`: Expected output for Windows only

Tests verify installer output matches expectations exactly (including skip messages).

### Feature Flags

Vim/NeoVim features are enabled via environment variables:
- `DOTFILES_VIM_GITHUB_COPILOT=y`: Enable GitHub Copilot
- `DOTFILES_VIM_LSP=y`: Enable Language Server Protocol
- `DOTFILES_VIM_LSP_AUTO_COMPLETE=y`: Enable LSP auto-complete
- `DOTFILES_VIM_NERDTREE=y`, `DOTFILES_VIM_FUGITIVE=y`, etc.: Enable specific plugins

See `ADD-ONS.md` for complete list and installation instructions.

### Vim Configuration Structure

- `src/dot.vim/vimrc`: Main Vim configuration (shared by Vim/NeoVim)
- Addons in `src/dot.vim/addons/`: One file per plugin, disabled by default (`.vim.disabled`)
- Fold markers used for code organization: `" {{{1` for level 1 folds, `" {{{2` for level 2
- Japanese comments in vimrc are acceptable (original author's convention)

### Shell Configuration

**Bash:**
- Main config: `src/dot.config/bash/main.sh`
- Hook in `.bashrc`: `. ~/.config/bash/main.sh`
- Functions prefixed with `dotfiles::` (e.g., `dotfiles::configure_editor`)

**PowerShell:**
- Main config: `src/dot.config/powershell/profile.ps1`
- Functions prefixed with `Invoke-My` for git aliases (e.g., `Invoke-MyGitStatus`)
- Global scope required for function definitions to persist

## Platform Differences to Consider

1. **Path separators**: Linux uses `/`, Windows uses `\` in DSL playbook
2. **Line endings**: Use `copy_crlf_win` for files requiring Windows CRLF line endings
3. **Profile locations**: 
   - Vim: `~/.vim/` (Linux) vs `~/vimfiles/` (Windows)
   - NeoVim: `~/.config/nvim/` (Linux) vs `~/AppData/Local/nvim/` (Windows)
4. **PowerShell versions**: Repository supports Windows PowerShell 5.1+ AND PowerShell 7+ (separate `$PROFILE` paths)

## Making Changes

### Modifying the Installer

When changing DSL syntax or installer logic:
1. Update both bash and PowerShell implementations
2. Add test case to `installers/tests/` with expected output
3. Run both test suites to verify
4. Ensure platform-specific output matches (`.linux.txt` vs `.windows.txt`)

### Adding New Configuration Files

1. Add source file to `src/` (with `dot.` prefix)
2. Add `copy` or platform-specific copy command to `playbook.dsl`
3. Test installation with `-c`/`-WhatIf` first
4. Consider if `.sample` suffix is appropriate for user-customizable files

### Updating Vim Configuration

- Maintain fold markers for code organization
- Keep functions prefixed with `MyVimrc` for clarity
- Document functions with comments (Japanese OK for internal docs)
- Test with minimum Vim version specified in README (Vim 8.2+, NeoVim 0.6+)

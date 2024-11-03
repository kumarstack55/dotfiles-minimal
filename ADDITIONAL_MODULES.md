# ADDITIONAL MODULES

To install additional modules, you need to install vim-plug, and enable a Vim script file by renaming it.

## Platforms

### Windows

```powershell
# powershell

# for Vim
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni $HOME/vimfiles/autoload/plug.vim -Force

# for NeoVim
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

Move-Item $HOME/vimfiles/subs/sub.vim.disabled $HOME/vimfiles/subs/sub.vim
```

### Linux

```bash
# for Vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# for Neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

diff -u $HOME/.vim/subs/sub.vim.disabled $HOME/.vim/subs/sub.vim

mv -i $HOME/.vim/subs/sub.vim.disabled $HOME/.vim/subs/sub.vim
```

## Enable features

### GitHub Copilot

```bash
# bash
export DOTFILES_VIM_GITHUB_COPILOT="y"
```

```powershell
# powershell
[System.Environment]::SetEnvironmentVariable("DOTFILES_VIM_GITHUB_COPILOT", "y", "User")
```

For more information:

- NeoVim
    - https://neovim.io/
- GitHub Copilot
    - https://github.com/features/copilot
    - https://docs.github.com/en/copilot/using-github-copilot/getting-code-suggestions-in-your-ide-with-github-copilot?tool=vimneovim
- Node.js
    - https://nodejs.org/en
    - https://nodejs.org/en/download/package-manager

### vim-lsp

```bash
# bash
export DOTFILES_VIM_LSP="y"
```

```powershell
# powershell
[System.Environment]::SetEnvironmentVariable("DOTFILES_VIM_LSP", "y", "User")
```

### NERDTree

```bash
# bash
export DOTFILES_VIM_NERDTREE="y"
```

```powershell
# powershell
[System.Environment]::SetEnvironmentVariable("DOTFILES_VIM_NERDTREE", "y", "User")
```

### BufExplorer

```bash
# bash
export DOTFILES_VIM_BUFEXPLORER="y"
```

```powershell
# powershell
[System.Environment]::SetEnvironmentVariable("DOTFILES_VIM_BUFEXPLORER", "y", "User")
```

### vim-gitgutter

```bash
# bash
export DOTFILES_VIM_GITGUTTER="y"
```

```powershell
# powershell
[System.Environment]::SetEnvironmentVariable("DOTFILES_VIM_GITGUTTER", "y", "User")
```

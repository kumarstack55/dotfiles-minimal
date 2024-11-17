# ADD-ONS

To install add-ons, you need to install vim-plug, and enable a Vim script file by renaming it.

## Platforms

### Linux

```bash
# for Vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# for Neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

diff -u $HOME/.vim/addons/main.vim.disabled $HOME/.vim/addons/main.vim

mv -i $HOME/.vim/addons/main.vim.disabled $HOME/.vim/addons/main.vim
```

### Windows

```powershell
# powershell

# for Vim
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni $HOME/vimfiles/autoload/plug.vim -Force

# for NeoVim
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

Remove-Item $HOME/vimfiles/addons/main.vim
Move-Item $HOME/vimfiles/addons/main.vim.disabled $HOME/vimfiles/addons/main.vim
```

## Enable features

### GitHub Copilot

```bash
# bash
export DOTFILES_VIM_GITHUB_COPILOT=y
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

### Other than GitHub Copilot

```bash
# bash
export DOTFILES_VIM_BUFEXPLORER=y
export DOTFILES_VIM_FUGITIVE=y
export DOTFILES_VIM_GITGUTTER=y
export DOTFILES_VIM_LSP=y
export DOTFILES_VIM_NERDTREE=y
export DOTFILES_VIM_SONICTEMPLATE=y
```

```powershell
# powershell
[System.Environment]::SetEnvironmentVariable("DOTFILES_VIM_BUFEXPLORER", "y", "User")
[System.Environment]::SetEnvironmentVariable("DOTFILES_VIM_FUGITIVE", "y", "User")
[System.Environment]::SetEnvironmentVariable("DOTFILES_VIM_GITGUTTER", "y", "User")
[System.Environment]::SetEnvironmentVariable("DOTFILES_VIM_LSP", "y", "User")
[System.Environment]::SetEnvironmentVariable("DOTFILES_VIM_NERDTREE", "y", "User")
[System.Environment]::SetEnvironmentVariable("DOTFILES_VIM_SONICTEMPLATE", "y", "User")
```

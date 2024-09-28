# ADDITIONAL MODULES

## Platforms

### Windows

```powershell
# powershell

iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni $HOME/vimfiles/autoload/plug.vim -Force

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

mv -i $HOME/.vim/subs/sub.vim.disabled $HOME/.vim/subs/sub.vim
```

## Enable features

### GitHub Copilot

```bash
export DOTFILES_VIM_GITHUB_COPILOT=y
```

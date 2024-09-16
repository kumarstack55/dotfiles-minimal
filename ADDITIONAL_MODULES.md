# ADDITIONAL MODULES

## Windows

```powershell
# powershell

iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni $HOME/vimfiles/autoload/plug.vim -Force

Copy-Item $HOME\repos\gh\dotfiles-minimal\dot.vim\plugins.vim.disabled $HOME/vimfiles/plugins.vim
```

## Linux

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cd dotfiles-minimal
cp dot.vim/plugins.vim.disabled $HOME/.vim/plugins.vim
```

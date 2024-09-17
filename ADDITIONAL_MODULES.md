# ADDITIONAL MODULES

## Windows

```powershell
# powershell

iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni $HOME/vimfiles/autoload/plug.vim -Force

Move-Item $HOME/vimfiles/plugin/after/sub/sub.vim.disabled $HOME/vimfiles/plugin/after/sub/sub.vim
```

## Linux

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mv -i $HOME/.vim/after/plugin/subs/sub.vim.disabled $HOME/.vim/after/plugin/subs/sub.vim
```

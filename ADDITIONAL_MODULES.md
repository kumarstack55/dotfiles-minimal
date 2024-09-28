# ADDITIONAL MODULES

## Windows

```powershell
# powershell

iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni $HOME/vimfiles/autoload/plug.vim -Force

Move-Item $HOME/vimfiles/subs/sub.vim.disabled $HOME/vimfiles/subs/sub.vim
```

## Linux

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mv -i $HOME/.vim/subs/sub.vim.disabled $HOME/.vim/subs/sub.vim
```

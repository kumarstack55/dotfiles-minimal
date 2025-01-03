scriptencoding utf-8

" Visual Studio Code の拡張 vscode-neovim を使うとき、何も設定しない。
" https://github.com/vscode-neovim/vscode-neovim
if exists('g:vscode')
  finish
endif

" Vim の設定を読む。
source $HOME\vimfiles\vimrc

" vim-cheatsheet のファイルを指定する。
if has('win32')
  let g:cheatsheet#cheat_file = $HOME . '\vimfiles\cheatsheet.md'
else
  let g:cheatsheet#cheat_file = $HOME . '\.vim\cheatsheet.md'
endif

scriptencoding utf-8

if has('win32')
  let my_vimrc_dir = '$HOME/vimfiles'
else
  let my_vimrc_dir = '$HOME/.vim'
endif

let g:sonictemplate_vim_template_dir = [
  \ my_vimrc_dir . '/template',
  \ my_vimrc_dir . '/local/templates/*',
\ ]

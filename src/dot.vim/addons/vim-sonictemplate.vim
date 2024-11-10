scriptencoding utf-8

if has('win32')
  let g:sonictemplate_vim_template_dir = [
    \ '$HOME/vimfiles/templates',
  \ ]
else
  let g:sonictemplate_vim_template_dir = [
    \ '$HOME/.vim/templates',
  \ ]
end

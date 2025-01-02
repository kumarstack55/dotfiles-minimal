scriptencoding utf-8

" universal-ctags の場合、 PowerShell 用のタグを生成する。
" https://github.com/preservim/tagbar/wiki#powershell
let g:tagbar_type_ps1 = {
  \ 'ctagstype': 'powershell',
  \ 'kinds': [
    \ 'e:enum',
    \ 'c:class',
    \ 'f:function',
    \ 'i:filter',
    \ 'v:variable'
  \ ]
\ }

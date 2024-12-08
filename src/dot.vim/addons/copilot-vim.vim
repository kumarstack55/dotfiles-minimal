scriptencoding utf-8

" ドキュメントが学習されることを回避するため Markdown を除く。
let g:copilot_filetypes = {
  \ '*': v:false,
  \ 'json': v:false,
  \ 'markdown': v:false,
  \ 'rst': v:false,
  \ 'text': v:false,
  \ 'yaml': v:false,
\ }

" コードとデータが分離されてそうなものは個別に有効にする。
let g:copilot_filetypes["bash"] = v:true
let g:copilot_filetypes["make"] = v:true
let g:copilot_filetypes["ps1"] = v:true
let g:copilot_filetypes["vim"] = v:true

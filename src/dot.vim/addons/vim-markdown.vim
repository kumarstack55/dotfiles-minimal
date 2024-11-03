" vim-markdown の折り畳みは使わない。
" ハイライトのために使うため。
let g:vim_markdown_folding_disabled = 1

" vim-markdown のキー・マッピングは使わない。
" ハイライトのために使うため。
let g:vim_markdown_no_default_key_mappings = 1

" コード・フェンスで標準に加え、言語を定義する。
let g:vim_markdown_fenced_languages = [
  \ 'bash=sh',
  \ 'c++=cpp',
  \ 'ini=dosini',
  \ 'viml=vim',
  \ 'powershell=ps1',
\ ]

" 自動で箇条書きのポイントを挿入することをやめる。
let g:vim_markdown_auto_insert_bullets = 0

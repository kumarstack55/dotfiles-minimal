scriptencoding utf-8

if has_key(g:plugs, 'vaffle.vim')
  " netrw の代わりに別のプラグイン Vaffle を使う。
  let g:NERDTreeHijackNetrw = 0
endif

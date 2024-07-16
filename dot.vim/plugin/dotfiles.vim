function! dotfiles#set_tabstop(ts)
  let &l:tabstop = a:ts
  let &l:shiftwidth = a:ts
  let &l:softtabstop = a:ts
  setlocal expandtab
endfunction

function! dotfiles#set_filetype_markdown()
  setlocal filetype=markdown
  call dotfiles#set_tabstop(4)
endfunction

function! dotfiles#set_filetype_ps1()
  setlocal filetype=ps1
  call dotfiles#set_tabstop(4)
endfunction

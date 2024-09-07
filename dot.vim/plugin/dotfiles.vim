let g:dotfiles#iskeyword_contains_hyphen = 0

function! dotfiles#toggle_iskeyword()
  if g:dotfiles#iskeyword_contains_hyphen
    echo 'Hyphen is used as delimiter.'
    set iskeyword-=-
  else
    echo 'Hyphens NOT used as delimiters.'
    set iskeyword+=-
  endif
  let g:dotfiles#iskeyword_contains_hyphen = (g:dotfiles#iskeyword_contains_hyphen + 1) % 2
endfunction

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

function! dotfiles#set_gui_font(font_height_pt)
  if !has('win32')
    return
  endif
  let font_name = g:gui_font_name
  let height = 'h' . a:font_height_pt
  let charset = 'cSHIFTJIS'
  let quality = 'qDEFAULT'
  let options = [g:gui_font_name, height, charset, quality]
  let guifont_string = join(options, ':')
  let &guifont = guifont_string
endfunction

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
let g:copilot_filetypes["css"] = v:true
let g:copilot_filetypes["javascript"] = v:true
let g:copilot_filetypes["make"] = v:true
let g:copilot_filetypes["ps1"] = v:true
let g:copilot_filetypes["python"] = v:true
let g:copilot_filetypes["sh"] = v:true
let g:copilot_filetypes["vim"] = v:true

" g:copilot_filetypes を上書きして有効・無効にするコマンドを定義する。
function! VimrcCopilotEnableForBuffer()
  let b:copilot_enabled = v:true
  Copilot status
endfunction
function! VimrcCopilotDisableForBuffer()
  let b:copilot_enabled = v:false
  Copilot status
endfunction
function! VimrcCopilotToggleEnabledForBuffer()
  let b:copilot_enabled = !get(b:, 'copilot_enabled', v:false)
  Copilot status
endfunction
command! MyCopilotEnableForBuffer call VimrcCopilotEnableForBuffer()
command! MyCopilotDisableForBuffer call VimrcCopilotDisableForBuffer()
command! MyCopilotToggleEnabledForBuffer call VimrcCopilotToggleEnabledForBuffer()

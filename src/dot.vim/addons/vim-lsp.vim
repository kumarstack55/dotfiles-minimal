scriptencoding utf-8

let g:lsp_diagnostics_enabled = 1
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

" デフォルトでは、自動でポップアップが表示されます。
" この機能は、 GitHub Copilot の動作と相性がよくないため、無効にします。
let g:asyncomplete_auto_popup = 0

" Ctrl + Space でポップアップを表示します。
imap <c-space> <Plug>(asyncomplete_force_refresh)

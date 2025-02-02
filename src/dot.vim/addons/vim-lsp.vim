scriptencoding utf-8

let g:lsp_diagnostics_enabled = 1
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/.config/vim/log/vim-lsp.log')

" デフォルトでは、自動でポップアップが表示されます。
" この機能は、 GitHub Copilot の動作と相性がよくないため、無効にします。
let g:asyncomplete_auto_popup = 0

" Ctrl + Space でポップアップを表示します。
imap <c-space> <Plug>(asyncomplete_force_refresh)

" Markdown 編集時に efm-langserver を有効にします。
" この設定は Markdown ファイルに対する textlint の実行で必要です。
let g:lsp_settings = {
  \ 'efm-langserver': {
  \   'disabled': 0,
  \   'allowlist': ['markdown'],
  \  }
  \ }

nmap <buffer> [g <plug>(lsp-previous-diagnostic)
nmap <buffer> ]g <plug>(lsp-next-diagnostic)

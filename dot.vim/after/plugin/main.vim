" このファイルは dotfiles.vim をロード後に実行される。
" そのため、 dotfiles.vim 内の関数を利用できる。

" 記号などをASCII文字の2倍幅として扱う。
set ambiwidth=double

" 起動時に `:intro` メッセージを表示しない。
set shortmess+=I

" すべてのイベントでベルを鳴らさない。
set belloff=all

" ウィンドウを <C-w>+<C-w>+ の代わりに <C-w>++ でサイズ変更する。
" https://zenn.dev/mattn/articles/83c2d4c7645faa
nmap <C-w>+ <C-w>+<SID>ws
nmap <C-w>- <C-w>-<SID>ws
nmap <C-w>> <C-w>><SID>ws
nmap <C-w>< <C-w><<SID>ws
nnoremap <script> <SID>ws+ <C-w>+<SID>ws
nnoremap <script> <SID>ws- <C-w>-<SID>ws
nnoremap <script> <SID>ws> <C-w>><SID>ws
nnoremap <script> <SID>ws< <C-w><<SID>ws
nmap <SID>ws <Nop>

" ファイル保存時に undo 履歴を保存しない。
set noundofile

" ファイル上書き前にバックアップを作らない。
set nobackup

" カラースキームを設定する。
let g:my_colorscheme = "habamax"
if dotfiles#test_colorscheme_exists(g:my_colorscheme)
  exec "colorscheme " . g:my_colorscheme
endif

" 同ファイルの複数編集に気づけるようスワップ・ファイルを作る。
set swapfile

" 新しい行を編集するとき、現在の行のインデントをコピーする。
set autoindent

" シンタックス・ハイライティングを有効にする。
syntax enable

" タブ文字の代わりに、スペースを挿入する。
set expandtab

" ファイル タイプごとにインデントを設定する。
augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.c,*.cpp,*.h setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.md call dotfiles#set_filetype_markdown()
  autocmd BufNewFile,BufRead *.ps1 call dotfiles#set_filetype_ps1()
  autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.rst setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.sh,*.bash setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.txt setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.vimrc,_gvimrc setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.yaml,*.yml setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" 新しいバッファから編集したときに、ファイルタイプの設定を適用するコマンドを定義する。
command! MyFiletypeMarkdown call dotfiles#set_filetype_markdown()
command! MyFiletypePs1 call dotfiles#set_filetype_ps1()

" plugins.vim ファイルがあれば読む。
let plugins_vim_path = $HOME . "\\vimfiles\\plugins.vim"
if filereadable(plugins_vim_path)
  exec "source " . fnameescape(plugins_vim_path)
endif

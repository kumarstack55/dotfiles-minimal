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

" 同ファイルの複数編集に気づけるようスワップ・ファイルを作る。
set swapfile

" シンタックス・ハイライティングを有効にする。
syntax enable

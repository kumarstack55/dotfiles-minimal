scriptencoding utf-8

if has_key(g:plugs, 'vaffle.vim')
  " netrw の代わりに別のプラグイン Vaffle を使う。
  let g:NERDTreeHijackNetrw = 0
endif

" Windows で HOME ディレクトリを参照する際、NERDTree が次のメッセージを
" 出力することがある。
" `NERDTree: 3 Invalid file(s): NTUSER.DAT, ntuser.dat.LOG1, ntuser.dat.LOG2`
"
" この対処方法は次の記載の通り、解決手段が無い。
" https://github.com/preservim/nerdtree/issues/1253#issuecomment-1772971733
" > Sadly there are no ways to turn off these warnings,
" > We used only to tell users some files were not loaded by NERDTree and
" > in the last few PRs we got a change that tells you what exact files
" > didn't get loaded.
" > This warning is a minor inconvenience, but it can mess with you if you
" > don't see some files you know should be there and don't know why.

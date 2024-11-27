scriptencoding utf-8

if has_key(g:plugs, 'vaffle.vim')
  " netrw の代わりに別のプラグイン Vaffle を使う。
  let g:NERDTreeHijackNetrw = 0
endif

if has('win32')
  " デフォルトの設定を指定する。
  let g:NERDTreeIgnore = ['\~$']

  " NTUSER.* が参照できなくともエラーを出力しない。
  " Windows でホーム・ディレクトリの直下に存在することがある NTUSER.* は、
  " 少なくとも NTUSER.DAT, ntuser.dat.LOG1, ntuser.dat.LOG2 は、
  " 参照できず、結果、エラーが表示される。これを回避する。
  call add(g:NERDTreeIgnore, '\c^ntuser\..*')
endif

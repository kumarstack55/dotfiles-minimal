# CHEATSHEET

## vim

### 差分

#### 後ろの差分、前の差分へ移動する。

`:Gvdiffsplit` などで表示される差分の表示で、差分をジャンプする。

- `]c` で後ろの差分へ移動する。
- `[c` で前の差分へ移動する。

## dotfiles

### ハイフン区切りを切り替える。

`*` などで単語を検索するとき、
`-` を区切りとしない、区切りとする、を切り替える。

```vim
:call VimrcToggleIsKeyword()
```

## vim-cheatsheet

### チートシートを表示する。

```vim
:Cheat
```

## tagbar

### タグバー表示/非表示を切り替える。

```vim
:Tagbar
```

## vaffle

```vim
:Vaffle
```

- 作成
    - `o`: ディレクトリを作る。
    - `i`: ファイルを作る。
- 変更
    - `r`: アイテムをリネームする。
- 削除
    - `d`: アイテムを消す。

## vim-surround

### 文字列を囲む。

Visual モードで `S"` でダブルクォートで囲む。

具体例として、

```text
{cursor}abc def ghi
```

で `fdvffS"` で次のようになる。

```text
abc "def" ghi
```

## editorconfig.vim

設定を再び読み込む。

```vim
:EditorConfigReload
```

https://editorconfig.org/

## vim-markdown

Markdown 内のテキストの文法をハイライトする他に、目次を作ることができる。

```vim
:Toc
```

## iceberg.vim

```vim
colorscheme iceberg
```

## vim-sonictemplate

プラグインに付属するテンプレートを使う。

```vim
:set ft=python
:Template main
```

追加したテンプレートを使う。

```vim
:set ft=markdown
:Template code
language: plaintext
```

Postfix Completion する。

```vim
:set ft=markdown
ipython.pre<c-y><c-b>
```

## vim-fugitive

### git status

```vim
:Git
```

- `g?` でヘルプを表示する。
- ファイルを選択して `a` で Staged に加える。
- ファイルを選択して `u` で Unstaged に戻す。
- ファイルを選択して `-` で Staged と Unstaged 間を切り替える。

### git add

```vim
:Gvdiffsplit
```

`:Gdiffsplit` (or `:Gvdiffsplit`) brings up the staged version of the file side by side with the working tree version.

ステージングのファイルと、ワーキング・ツリーのファイルを、差分で編集する画面になる。

ワーキング・ツリーのバッファで、差分を選択して、

- `do` または `:diffget` で、ステージングをワーキング・ツリーのバッファに反映する。
- `dp` または `:diffput` で、ワーキング・ツリーからステージングのバッファに反映する。

あるいは、ステージングのバッファで、差分を選択して、

- `do` または `:diffget` で、ワーキング・ツリーをステージングのバッファに反映する。
- `dp` または `:diffput` で、ステージングからワーキング・ツリーのバッファに反映する。

より細かい粒度で差分を選択するには、
ワーキング・ツリーのバッファで、Visual モードで行選択して、
`:'<,'>diffget` または `:'<,'>diffput` で行単位で差分を選択できる。

変更後、ステージングのバッファの保存を忘れずに。

`:Git` との相性はよくなさそう。混ぜないほうが良さそう。

### git commit

```vim
:Git commit
```

### git log

```vim
:GcLog
```

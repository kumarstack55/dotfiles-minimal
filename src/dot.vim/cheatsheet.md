# CHEATSHEET

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

# CHEATSHEET

## dotfiles

### ハイフンを区切りとするか否かを切り替える

`*` などで単語を検索するとき、
`-` を区切りとしない、区切りとする、を切り替える。

```vim
:call dotfiles#toggle_iskeyword()
```

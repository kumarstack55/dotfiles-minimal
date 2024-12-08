# vim:ft=config ts=8:
[core]
	# コミット時に crlf を lf にする。
	# https://git-scm.com/docs/gitattributes#_end_of_line_conversion
	autocrlf = input

	# パス出力時に、バックスラッシュでエスケープせずに出力する。
	# https://git-scm.com/docs/git-config#Documentation/git-config.txt-corequotePath
	quotepath = false

[init]
	# リポジトリが作られたとき、ブランチ名を main にする。
	# https://git-scm.com/docs/git-init/en
	defaultBranch = main

[include]
	path = ~/.config/git/local/config.inc

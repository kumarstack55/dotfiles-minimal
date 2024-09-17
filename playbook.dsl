mkdir_linux "${HOME}/.vim"
mkdir_win   "${HOME}\\vimfiles"

copy_linux "dot.vim/cheatsheet.md"  "${HOME}/.vim/cheatsheet.md"
copy_win   "dot.vim\\cheatsheet.md" "${HOME}\\vimfiles\\cheatsheet.md"

copy_linux "dot.vim/vimrc"  "${HOME}/.vim/vimrc"
copy_win   "dot.vim\\vimrc" "${HOME}\\vimfiles\\vimrc"

copy_win "dot.vim\\gvimrc" "${HOME}\\vimfiles\\gvimrc"

mkdir_linux "${HOME}/.vim/plugin"
mkdir_win   "${HOME}\\vimfiles\\plugin"

copy_linux "dot.vim/plugin/dotfiles.vim"   "${HOME}/.vim/plugin/dotfiles.vim"
copy_win   "dot.vim\\plugin\\dotfiles.vim" "${HOME}\\vimfiles\\plugin\\dotfiles.vim"

mkdir_linux "${HOME}/.vim/after"
mkdir_win   "${HOME}\\vimfiles\\after"

mkdir_linux "${HOME}/.vim/after/plugin"
mkdir_win   "${HOME}\\vimfiles\\after\\plugin"

copy_linux "dot.vim/after/plugin/dotfiles.vim"    "${HOME}/.vim/after/plugin/dotfiles.vim"
copy_win   "dot.vim\\after\\plugin\\dotfiles.vim" "${HOME}\\vimfiles\\after\\plugin\\dotfiles.vim"

mkdir_linux "${HOME}/.vim/after/plugin/subs"
mkdir_win   "${HOME}\\vimfiles\\after\\plugin\\subs"

copy_linux "dot.vim/after/plugin/subs/sub.vim.disabled"     "${HOME}/.vim/after/plugin/subs/sub.vim.disabled"
copy_win   "dot.vim\\after\\plugin\\subs\\sub.vim.disabled" "${HOME}\\vimfiles\\after\\plugin\\subs\\sub.vim.disabled"

copy_linux "dot.editorconfig" "${HOME}/.editorconfig"
copy_win   "dot.editorconfig" "${HOME}\\.editorconfig"

copy_linux "dot.gitconfig" "${HOME}/.gitconfig"
copy_win   "dot.gitconfig" "${HOME}\\.gitconfig"

copy_win "Documents\\WindowsPowerShell\\Microsoft.PowerShell_profile.ps1" "${PROFILE}"

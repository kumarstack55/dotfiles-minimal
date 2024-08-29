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

copy_linux "dot.editorconfig" "${HOME}/.editorconfig"
copy_win   "dot.editorconfig" "${HOME}\\.editorconfig"

copy_linux "dot.gitconfig" "${HOME}/.gitconfig"
copy_win   "dot.gitconfig" "${HOME}\\.gitconfig"

copy_win "Documents\\WindowsPowerShell\\Microsoft.PowerShell_profile.ps1" "${PROFILE}"

mkdir_linux "${HOME}/.config"

mkdir_linux "${HOME}/.config/bash"

copy_linux "src/dot.config/bash/main.sh" "${HOME}/.config/bash/main.sh"

mkdir_linux "${HOME}/.vim"
mkdir_win   "${HOME}\\vimfiles"

copy_linux "src/dot.vim/cheatsheet.md"   "${HOME}/.vim/cheatsheet.md"
copy_win   "src\\dot.vim\\cheatsheet.md" "${HOME}\\vimfiles\\cheatsheet.md"

copy_linux "src/dot.vim/vimrc"  "${HOME}/.vim/vimrc"
copy_win   "src\\dot.vim\\vimrc" "${HOME}\\vimfiles\\vimrc"

copy_win "src/dot.vim\\gvimrc" "${HOME}\\vimfiles\\gvimrc"

mkdir_linux "${HOME}/.vim/plugin"
mkdir_win   "${HOME}\\vimfiles\\plugin"

copy_linux "src/dot.vim/plugin/dotfiles.vim"    "${HOME}/.vim/plugin/dotfiles.vim"
copy_win   "src\\dot.vim\\plugin\\dotfiles.vim" "${HOME}\\vimfiles\\plugin\\dotfiles.vim"

mkdir_linux "${HOME}/.vim/after"
mkdir_win   "${HOME}\\vimfiles\\after"

mkdir_linux "${HOME}/.vim/after/plugin"
mkdir_win   "${HOME}\\vimfiles\\after\\plugin"

copy_linux "src/dot.vim/after/plugin/dotfiles.vim"     "${HOME}/.vim/after/plugin/dotfiles.vim"
copy_win   "src\\dot.vim\\after\\plugin\\dotfiles.vim" "${HOME}\\vimfiles\\after\\plugin\\dotfiles.vim"

mkdir_linux "${HOME}/.vim/after/plugin/subs"
mkdir_win   "${HOME}\\vimfiles\\after\\plugin\\subs"

copy_linux "src/dot.vim/after/plugin/subs/sub.vim.disabled"      "${HOME}/.vim/after/plugin/subs/sub.vim.disabled"
copy_win   "src\\dot.vim\\after\\plugin\\subs\\sub.vim.disabled" "${HOME}\\vimfiles\\after\\plugin\\subs\\sub.vim.disabled"

copy_linux "src/dot.vim/after/plugin/subs/vim-cheatsheet.vim"      "${HOME}/.vim/after/plugin/subs/vim-cheatsheet.vim"
copy_win   "src\\dot.vim\\after\\plugin\\subs\\vim-cheatsheet.vim" "${HOME}\\vimfiles\\after\\plugin\\subs\\vim-cheatsheet.vim"

copy_linux "src/dot.vim/after/plugin/subs/vim-markdown.vim"      "${HOME}/.vim/after/plugin/subs/vim-markdown.vim"
copy_win   "src\\dot.vim\\after\\plugin\\subs\\vim-markdown.vim" "${HOME}\\vimfiles\\after\\plugin\\subs\\vim-markdown.vim"

copy_linux "src/dot.editorconfig" "${HOME}/.editorconfig"
copy_win   "src\\dot.editorconfig" "${HOME}\\.editorconfig"

copy_linux "src/dot.gitconfig" "${HOME}/.gitconfig"
copy_win   "src\\dot.gitconfig" "${HOME}\\.gitconfig"

copy_win "src\\Documents\\WindowsPowerShell\\Microsoft.PowerShell_profile.ps1" "${PROFILE}"

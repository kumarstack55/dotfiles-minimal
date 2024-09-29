mkdir_linux "${HOME}/.config"

mkdir_linux "${HOME}/.config/bash"

copy_linux "src/dot.config/bash/main.sh" "${HOME}/.config/bash/main.sh"

copy_linux "src/dot.config/bash/env.sh" "${HOME}/.config/bash/env.sh"

mkdir_linux "${HOME}/.config/nvim"

copy_linux "src/dot.config/nvim/init.vim" "${HOME}/.config/nvim/init.vim"

mkdir_linux "${HOME}/.vim"
mkdir_win   "${HOME}\\vimfiles"

copy_linux "src/dot.vim/cheatsheet.md"   "${HOME}/.vim/cheatsheet.md"
copy_win   "src\\dot.vim\\cheatsheet.md" "${HOME}\\vimfiles\\cheatsheet.md"

copy_linux "src/dot.vim/vimrc"  "${HOME}/.vim/vimrc"
copy_win   "src\\dot.vim\\vimrc" "${HOME}\\vimfiles\\vimrc"

copy_win "src/dot.vim\\gvimrc" "${HOME}\\vimfiles\\gvimrc"

mkdir_linux "${HOME}/.vim/subs"
mkdir_win   "${HOME}\\vimfiles\\subs"

copy_linux "src/dot.vim/subs/sub.vim.disabled"     "${HOME}/.vim/subs/sub.vim.disabled"
copy_win   "src\\dot.vim\\subs\\sub.vim.disabled" "${HOME}\\vimfiles\\subs\\sub.vim.disabled"

copy_linux "src/dot.vim/subs/vim-cheatsheet.vim"     "${HOME}/.vim/subs/vim-cheatsheet.vim"
copy_win   "src\\dot.vim\\subs\\vim-cheatsheet.vim" "${HOME}\\vimfiles\\subs\\vim-cheatsheet.vim"

copy_linux "src/dot.vim/subs/vim-markdown.vim"     "${HOME}/.vim/subs/vim-markdown.vim"
copy_win   "src\\dot.vim\\subs\\vim-markdown.vim" "${HOME}\\vimfiles\\subs\\vim-markdown.vim"

copy_linux "src/dot.editorconfig" "${HOME}/.editorconfig"
copy_win   "src\\dot.editorconfig" "${HOME}\\.editorconfig"

copy_linux "src/dot.gitconfig" "${HOME}/.gitconfig"
copy_win   "src\\dot.gitconfig" "${HOME}\\.gitconfig"

copy_win "src\\Documents\\WindowsPowerShell\\Microsoft.PowerShell_profile.ps1" "${PROFILE}"

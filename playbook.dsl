mkdir_linux "${HOME}/.vim"
mkdir_win "${HOME}\\vimfiles"

copy_linux "dot.vimrc" "${HOME}/.vim/vimrc"
copy_win "dot.vimrc" "${HOME}\\.vimrc"

copy_win "_gvimrc" "${HOME}\\_gvimrc"

mkdir_linux "${HOME}/.vim/plugin"
copy_linux "dot.vim/plugin/dotfiles.vim" "${HOME}/.vim/plugin/dotfiles.vim"

copy_win "Documents\\WindowsPowerShell\\Microsoft.PowerShell_profile.ps1" "${PROFILE}"

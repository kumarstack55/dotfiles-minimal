set_linux "src_init_vim_filename" "init.vim"
set_win "src_init_vim_filename" "init_windows.vim"

# dir: $HOME
copy "src/dot.editorconfig" "${HOME}/.editorconfig"
copy "src/dot.gitconfig" "${HOME}/.gitconfig"
copy_linux "src/dot.ansible.cfg" "${HOME}/.ansible.cfg"
copy_win "src/dot.vsvimrc" "${HOME}/.vsvimrc"

# dir: $HOME/.config
mkdir "${HOME}/.config"

# dir: $HOME/.config/bash
mkdir "${HOME}/.config/bash"
copy "src/dot.config/bash/main.sh" "${HOME}/.config/bash/main.sh"
copy "src/dot.config/bash/env.sh" "${HOME}/.config/bash/env.sh"

# dir: $HOME/.config/nvim
mkdir_linux "${HOME}/.config/nvim"
copy_linux "src/dot.config/nvim/${src_init_vim_filename}" "${HOME}/.config/nvim/init.vim"

# dir: $HOME/.config/powershell
mkdir_win "${HOME}/.config/powershell"
copy_win "src/dot.config/powershell/env.ps1" "${HOME}/.config/powershell/env.ps1"

# dir: $HOME/AppData/Local/nvim
mkdir_win "${HOME}\\AppData\\Local\\nvim"
copy_win "src/dot.config/nvim/${src_init_vim_filename}" "${HOME}\\AppData\\Local\\nvim\\init.vim"

# dir: $HOME/.vim
set_linux "vimrc_dir" ".vim"
set_win "vimrc_dir" "vimfiles"
mkdir "${HOME}/${vimrc_dir}"
copy "src/dot.vim/cheatsheet.md" "${HOME}/${vimrc_dir}/cheatsheet.md"
copy "src/dot.vim/vimrc" "${HOME}/${vimrc_dir}/vimrc"
copy_win "src\\dot.vim\\gvimrc" "${HOME}\\${vimrc_dir}\\gvimrc"

# dir: $HOME/.vim/subs
mkdir "${HOME}/${vimrc_dir}/subs"
copy "src/dot.vim/subs/sub.vim.disabled" "${HOME}/${vimrc_dir}/subs/sub.vim.disabled"
copy "src/dot.vim/subs/vim-cheatsheet.vim" "${HOME}/${vimrc_dir}/subs/vim-cheatsheet.vim"
copy "src/dot.vim/subs/vim-markdown.vim" "${HOME}/${vimrc_dir}/subs/vim-markdown.vim"
copy "src/dot.vim/subs/vim-lsp.vim" "${HOME}/${vimrc_dir}/subs/vim-lsp.vim"

# file: $PROFILE
copy_crlf_win "src\\Documents\\WindowsPowerShell\\Microsoft.PowerShell_profile.ps1" "${PROFILE}"

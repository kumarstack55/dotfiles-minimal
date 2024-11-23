set_linux "src_init_vim_filename" "init.vim"
set_win "src_init_vim_filename" "init_windows.vim"

copy "src/dot.editorconfig" "${HOME}/.editorconfig"
copy "src/dot.gitconfig" "${HOME}/.gitconfig"
copy "src/dot.gitconfig_generic.inc" "${HOME}/.gitconfig_generic.inc"
copy_linux "src/dot.ansible.cfg" "${HOME}/.ansible.cfg"
copy_win "src/dot.vsvimrc" "${HOME}/.vsvimrc"

mkdir "${HOME}/.config"

mkdir "${HOME}/.config/bash"
copy "src/dot.config/bash/main.sh" "${HOME}/.config/bash/main.sh"

mkdir "${HOME}/.config/bash/local"
copy "src/dot.config/bash/local/env-vim.sh.sample" "${HOME}/.config/bash/local/env-vim.sh.sample"

mkdir_linux "${HOME}/.config/nvim"
copy_linux "src/dot.config/nvim/${src_init_vim_filename}" "${HOME}/.config/nvim/init.vim"

mkdir_win "${HOME}/.config/powershell"

mkdir_win "${HOME}/.config/powershell/local"

mkdir_win "${HOME}\\AppData\\Local\\nvim"
copy_win "src/dot.config/nvim/${src_init_vim_filename}" "${HOME}\\AppData\\Local\\nvim\\init.vim"

set_linux "vimrc_dir" ".vim"
set_win "vimrc_dir" "vimfiles"
mkdir "${HOME}/${vimrc_dir}"
copy "src/dot.vim/cheatsheet.md" "${HOME}/${vimrc_dir}/cheatsheet.md"
copy "src/dot.vim/vimrc" "${HOME}/${vimrc_dir}/vimrc"
copy_win "src\\dot.vim\\gvimrc" "${HOME}\\${vimrc_dir}\\gvimrc"

mkdir "${HOME}/${vimrc_dir}/addons"
copy "src/dot.vim/addons/main.vim.disabled" "${HOME}/${vimrc_dir}/addons/main.vim.disabled"
copy "src/dot.vim/addons/vim-cheatsheet.vim" "${HOME}/${vimrc_dir}/addons/vim-cheatsheet.vim"
copy "src/dot.vim/addons/vim-markdown.vim" "${HOME}/${vimrc_dir}/addons/vim-markdown.vim"
copy "src/dot.vim/addons/vim-lsp.vim" "${HOME}/${vimrc_dir}/addons/vim-lsp.vim"
copy "src/dot.vim/addons/vim-sonictemplate.vim" "${HOME}/${vimrc_dir}/addons/vim-sonictemplate.vim"

mkdir "${HOME}/${vimrc_dir}/template"

mkdir "${HOME}/${vimrc_dir}/template/markdown"
copy "src/dot.vim/template/markdown/pattern.stpl" "${HOME}/${vimrc_dir}/template/markdown/pattern.stpl"
copy "src/dot.vim/template/markdown/snip-code.md" "${HOME}/${vimrc_dir}/template/markdown/snip-code.md"
copy "src/dot.vim/template/markdown/snip-code-bash.md" "${HOME}/${vimrc_dir}/template/markdown/snip-code-bash.md"
copy "src/dot.vim/template/markdown/snip-code-markdown.md" "${HOME}/${vimrc_dir}/template/markdown/snip-code-markdown.md"
copy "src/dot.vim/template/markdown/snip-code-plaintext.md" "${HOME}/${vimrc_dir}/template/markdown/snip-code-plaintext.md"
copy "src/dot.vim/template/markdown/snip-code-posh.md" "${HOME}/${vimrc_dir}/template/markdown/snip-code-posh.md"

mkdir "${HOME}/${vimrc_dir}/local"

mkdir "${HOME}/${vimrc_dir}/local/templates"

copy_crlf_win "src\\Documents\\WindowsPowerShell\\Microsoft.PowerShell_profile.ps1" "${PROFILE}"

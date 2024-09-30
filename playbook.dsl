set_linux "vimrc_dir" ".vim"
set_win "vimrc_dir" "vimfiles"

join_path "src_path_cheatsheet_md" "src" "dot.vim" "cheatsheet.md"
join_path "src_path_vimrc" "src" "dot.vim" "vimrc"
join_path "src_path_sub_vim" "src" "dot.vim" "subs" "sub.vim.disabled"
join_path "src_path_cheatsheet_vim" "src" "dot.vim" "subs" "vim-cheatsheet.vim"
join_path "src_path_vim_markdown" "src" "dot.vim" "subs" "vim-markdown.vim"
join_path "src_path_vim_lsp_vim" "src" "dot.vim" "subs" "vim-lsp.vim"
join_path "src_path_dot_editorconfig" "src" "dot.editorconfig"
join_path "src_path_dot_gitconfig" "src" "dot.gitconfig"

join_path "dst_path_vim_dir" "${HOME}" "${vimrc_dir}"
join_path "dst_path_cheatsheet_md" "${dst_path_vim_dir}" "cheatsheet.md"
join_path "dst_path_vimrc" "${dst_path_vim_dir}" "vimrc"
join_path "dst_path_subs_dir" "${dst_path_vim_dir}" "subs"
join_path "dst_path_sub_vim" "${dst_path_subs_dir}" "sub.vim.disabled"
join_path "dst_path_cheatsheet_vim" "${dst_path_subs_dir}" "vim-cheatsheet.vim"
join_path "dst_path_vim_markdown" "${dst_path_subs_dir}" "vim-markdown.vim"
join_path "dst_path_vim_lsp_vim" "${dst_path_subs_dir}" "vim-lsp.vim"
join_path "dst_path_dot_editorconfig" "${HOME}" ".editorconfig"
join_path "dst_path_dot_gitconfig" "${HOME}" ".gitconfig"

# dir: $HOME
copy "${src_path_dot_editorconfig}" "${dst_path_dot_editorconfig}"
copy "${src_path_dot_gitconfig}" "${dst_path_dot_gitconfig}"

# dir: $HOME/.config
mkdir_linux "${HOME}/.config"

# dir: $HOME/.config/bash
mkdir_linux "${HOME}/.config/bash"
copy_linux "src/dot.config/bash/main.sh" "${HOME}/.config/bash/main.sh"
copy_linux "src/dot.config/bash/env.sh" "${HOME}/.config/bash/env.sh"

# dir: $HOME/.config/nvim
mkdir_linux "${HOME}/.config/nvim"
copy_linux "src/dot.config/nvim/init.vim" "${HOME}/.config/nvim/init.vim"

# dir: $HOME/.vim
mkdir "${dst_path_vim_dir}"
copy "${src_path_cheatsheet_md}" "${dst_path_cheatsheet_md}"
copy "${src_path_vimrc}" "${dst_path_vimrc}"
copy_win "src/dot.vim\\gvimrc" "${dst_path_vim_dir}\\gvimrc"

# dir: $HOME/.vim/subs
mkdir "${dst_path_subs_dir}"
copy "${src_path_sub_vim}" "${dst_path_sub_vim}"
copy "${src_path_cheatsheet_vim}" "${dst_path_cheatsheet_vim}"
copy "${src_path_vim_markdown}" "${dst_path_vim_markdown}"
copy "${src_path_vim_lsp_vim}" "${dst_path_vim_lsp_vim}"

# dir: $PROFILE
copy_win "src\\Documents\\WindowsPowerShell\\Microsoft.PowerShell_profile.ps1" "${PROFILE}"

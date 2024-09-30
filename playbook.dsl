set_linux "vimrc_dir" ".vim"
set_win "vimrc_dir" "vimfiles"

set_linux "src_init_vim_filename" "init.vim"
set_win "src_init_vim_filename" "init_windows.vim"

join_path "dst_path_config_dir" "${HOME}" ".config"
join_path "dst_path_bash_dir" "${dst_path_config_dir}" "bash"
join_path "dst_path_bash_main_sh" "${dst_path_bash_dir}" "main.sh"
join_path "dst_path_bash_env_sh" "${dst_path_bash_dir}" "env.sh"
join_path "dst_path_nvim_dir" "${dst_path_config_dir}" "nvim"

set_win "dst_path_nvim_dir_win" "${HOME}\\AppData\\Local\\nvim"

join_path "src_path_bash_main_sh" "src" "dot.config" "bash" "main.sh"
join_path "src_path_bash_env_sh" "src" "dot.config" "bash" "env.sh"
join_path "src_path_nvim_init_vim" "src" "dot.config" "nvim" "${src_init_vim_filename}"

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
mkdir "${dst_path_config_dir}"

# dir: $HOME/.config/bash
mkdir "${dst_path_bash_dir}"
copy "${src_path_bash_main_sh}" "${dst_path_bash_main_sh}"
copy "${src_path_bash_env_sh}" "${dst_path_bash_env_sh}"

# dir: $HOME/.config/nvim
mkdir_linux "${dst_path_nvim_dir}"
copy_linux "${src_path_nvim_init_vim}" "${dst_path_nvim_dir}/init.vim"

# dir: $HOME/AppData/Local/nvim
mkdir_win "${dst_path_nvim_dir_win}"
copy_win "${src_path_nvim_init_vim}" "${dst_path_nvim_dir_win}\\init.vim"

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
copy_crlf_win "src\\Documents\\WindowsPowerShell\\Microsoft.PowerShell_profile.ps1" "${PROFILE}"

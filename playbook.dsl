set_linux "src_init_vim_filename" "init.vim"
set_win "src_init_vim_filename" "init_windows.vim"

copy_linux "src/dot.ansible.cfg" "${HOME}/.ansible.cfg"
copy_win "src/dot.archiveconfig.json.sample" "${HOME}/.archiveconfig.json.sample"
copy "src/dot.editorconfig" "${HOME}/.editorconfig"
copy "src/dot.gitconfig" "${HOME}/.gitconfig"
copy_win "src/dot.vsvimrc" "${HOME}/.vsvimrc"

mkdir "${HOME}/.config"

mkdir "${HOME}/.config/bash"
copy "src/dot.config/bash/main.sh" "${HOME}/.config/bash/main.sh"

mkdir "${HOME}/.config/bash/local"
copy "src/dot.config/bash/local/env-vim.sh.sample" "${HOME}/.config/bash/local/env-vim.sh.sample"

mkdir_linux "${HOME}/.config/efm-langserver"
copy_linux "src/dot.config/efm-langserver/config.yaml" "${HOME}/.config/efm-langserver/config.yaml"

mkdir "${HOME}/.config/git"
copy "src/dot.config/git/gitconfig.inc" "${HOME}/.config/git/gitconfig.inc"

mkdir "${HOME}/.config/git/local"
copy "src/dot.config/git/local/gitconfig_local.inc.sample" "${HOME}/.config/git/local/gitconfig_local.inc.sample"

mkdir_linux "${HOME}/.config/nvim"
copy_linux "src/dot.config/nvim/${src_init_vim_filename}" "${HOME}/.config/nvim/init.vim"

mkdir_win "${HOME}/.config/powershell"
copy_win "src/dot.config/powershell/profile.ps1" "${HOME}/.config/powershell/profile.ps1"

mkdir_win "${HOME}/.config/powershell/local"
copy_win "src/dot.config/powershell/local/bootstrap.ps1" "${HOME}/.config/powershell/local/bootstrap.ps1"

mkdir_win "${HOME}/.config/powershell/local/my"
copy_win "src/dot.config/powershell/local/my/Move-MyFileItemToDatePrefixedFolder.ps1" "${HOME}/.config/powershell/local/my/Move-MyFileItemToDatePrefixedFolder.ps1"
copy_win "src/dot.config/powershell/local/my/Move-MyFileItemToDatePrefixedFolder.Tests.ps1" "${HOME}/.config/powershell/local/my/Move-MyFileItemToDatePrefixedFolder.Tests.ps1"
copy_win "src/dot.config/powershell/local/my/Move-MyFolderItemToArchiveFolder.ps1" "${HOME}/.config/powershell/local/my/Move-MyFolderItemToArchiveFolder.ps1"
copy_win "src/dot.config/powershell/local/my/Move-MyFolderItemToArchiveFolder.Tests.ps1" "${HOME}/.config/powershell/local/my/Move-MyFolderItemToArchiveFolder.Tests.ps1"
copy_win "src/dot.config/powershell/local/my/New-MyArchiveConfigJson.ps1" "${HOME}/.config/powershell/local/my/New-MyArchiveConfigJson.ps1"
copy_win "src/dot.config/powershell/local/my/New-MyArchiveConfigJson.Tests.ps1" "${HOME}/.config/powershell/local/my/New-MyArchiveConfigJson.Tests.ps1"
copy_win "src/dot.config/powershell/local/my/New-MyDatePrefixedFolder.ps1" "${HOME}/.config/powershell/local/my/New-MyDatePrefixedFolder.ps1"
copy_win "src/dot.config/powershell/local/my/New-MyDatePrefixedFolder.Tests.ps1" "${HOME}/.config/powershell/local/my/New-MyDatePrefixedFolder.Tests.ps1"
copy_win "src/dot.config/powershell/local/my/classes.ps1" "${HOME}/.config/powershell/local/my/classes.ps1"

mkdir "${HOME}/.config/vim"

mkdir "${HOME}/.config/vim/local"

mkdir "${HOME}/.config/vim/local/templates"

mkdir "${HOME}/.config/vim/log"

mkdir "${HOME}/.config/vim/swap"

mkdir_win "${HOME}\\AppData\\Local\\nvim"
copy_win "src/dot.config/nvim/${src_init_vim_filename}" "${HOME}\\AppData\\Local\\nvim\\init.vim"

set_linux "vimrc_dir" ".vim"
set_win "vimrc_dir" "vimfiles"
mkdir "${HOME}/${vimrc_dir}"
copy "src/dot.vim/cheatsheet.md" "${HOME}/${vimrc_dir}/cheatsheet.md"
copy "src/dot.vim/vimrc" "${HOME}/${vimrc_dir}/vimrc"
copy_win "src\\dot.vim\\gvimrc" "${HOME}\\${vimrc_dir}\\gvimrc"
copy "src/dot.vim/vader.vader" "${HOME}/${vimrc_dir}/vader.vader"

mkdir "${HOME}/${vimrc_dir}/test"
copy "src/dot.vim/test/test_markdown.vader" "${HOME}/${vimrc_dir}/test/test_markdown.vader"

mkdir "${HOME}/${vimrc_dir}/test/include"
copy "src/dot.vim/test/include/setup.vader" "${HOME}/${vimrc_dir}/test/include/setup.vader"
copy "src/dot.vim/test/include/teardown.vader" "${HOME}/${vimrc_dir}/test/include/teardown.vader"

mkdir "${HOME}/${vimrc_dir}/addons"
copy "src/dot.vim/addons/main.vim.disabled" "${HOME}/${vimrc_dir}/addons/main.vim.disabled"
copy "src/dot.vim/addons/copilot-vim.vim" "${HOME}/${vimrc_dir}/addons/copilot-vim.vim"
copy "src/dot.vim/addons/nerdtree.vim" "${HOME}/${vimrc_dir}/addons/nerdtree.vim"
copy "src/dot.vim/addons/tagbar.vim" "${HOME}/${vimrc_dir}/addons/tagbar.vim"
copy "src/dot.vim/addons/vim-cheatsheet.vim" "${HOME}/${vimrc_dir}/addons/vim-cheatsheet.vim"
copy "src/dot.vim/addons/vim-lsp.vim" "${HOME}/${vimrc_dir}/addons/vim-lsp.vim"
copy "src/dot.vim/addons/vim-markdown.vim" "${HOME}/${vimrc_dir}/addons/vim-markdown.vim"
copy "src/dot.vim/addons/vim-sonictemplate.vim" "${HOME}/${vimrc_dir}/addons/vim-sonictemplate.vim"

mkdir "${HOME}/${vimrc_dir}/template"

mkdir "${HOME}/${vimrc_dir}/template/markdown"
copy "src/dot.vim/template/markdown/pattern.stpl" "${HOME}/${vimrc_dir}/template/markdown/pattern.stpl"
copy "src/dot.vim/template/markdown/snip-code.md" "${HOME}/${vimrc_dir}/template/markdown/snip-code.md"
copy "src/dot.vim/template/markdown/snip-code-bash.md" "${HOME}/${vimrc_dir}/template/markdown/snip-code-bash.md"
copy "src/dot.vim/template/markdown/snip-code-markdown.md" "${HOME}/${vimrc_dir}/template/markdown/snip-code-markdown.md"
copy "src/dot.vim/template/markdown/snip-code-plaintext.md" "${HOME}/${vimrc_dir}/template/markdown/snip-code-plaintext.md"
copy "src/dot.vim/template/markdown/snip-code-posh.md" "${HOME}/${vimrc_dir}/template/markdown/snip-code-posh.md"

mkdir_win "${APPDATA}\\efm-langserver"
copy_win "src\\dot.config\\efm-langserver\\config.yaml" "${APPDATA}\\efm-langserver\\config.yaml"

# PowerShell によって PROFILE の場所が異なる点に注意が必要です。
# 少なくとも OneDrive なしの Windows PowerShell と PowerShell 7 で異なることがわかっています。
# Windows PowerShell 5.1:
#   $HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
# PowerShell 7+:
#   $HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
copy_crlf_win "src\\Documents\\WindowsPowerShell\\Microsoft.PowerShell_profile.ps1" "${PROFILE}"

# Ubuntu

```bash
# bash

# WSL: sudo
(uname -r | grep -qi wsl2) && (echo 'ubuntu ALL = (ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/ubuntu >/dev/null)

# curl, unzip
sudo apt update
(c="curl"; type -p "${c}" >/dev/null || sudo apt-get install "${c}" -y)
(c="unzip"; type -p "${c}" >/dev/null || sudo apt-get install "${c}" -y)

# gh
# https://github.com/cli/cli/blob/trunk/docs/install_linux.md
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
    && sudo mkdir -p -m 755 /etc/apt/keyrings \
        && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y
gh auth login

# dotfiles
git clone https://github.com/kumarstack55/dotfiles-minimal.git
cd ./dotfiles-minimal
./installers/bash/install.sh -f ./playbook.dsl
./ensure_that_hook_line_exists_in_bashrc.sh

# Neovim
# https://github.com/neovim/neovim/blob/master/INSTALL.md#linux
cd $(mktemp -d)
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# Node.js
# https://nodejs.org/ja/download
curl -o- https://fnm.vercel.app/install | bash
cat <<'__BASH__' | tee ~/.config/bash/local/fnm.sh
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
__BASH__
. $HOME/.bashrc
fnm install --latest

# Neovim plugins
grep '^export DOTFILES_VIM_' ./ADD-ONS.md \
| grep -v 'DOTFILES_VIM_VADER' \
| sort \
| tee ~/.config/bash/local/env-vim.sh >/dev/null
. $HOME/.bashrc
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mv -i $HOME/.vim/addons/main.vim.disabled $HOME/.vim/addons/main.vim
nvim -c 'PlugInstall'
nvim -c 'Copilot auth'
```

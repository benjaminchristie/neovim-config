#!/bin/sh

# NVIM install
mkdir -p ~/.config/nvim/bin/
mkdir -p ~/.local/bin/
git clone https://github.com/neovim/neovim.git /tmp/neovim
cd /tmp/neovim/ && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
# VIM-PLUG install
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
## various dependencies
# fzf
git clone https://github.com/junegunn/fzf /tmp/fzf
cd /tmp/fzf/ && ./install --all
cp /tmp/fzf/bin/fzf ~/.local/bin/
# DAPs
cd /tmp && wget https://github.com/microsoft/vscode-cpptools/releases/download/v1.16.3/cpptools-linux.vsix 
unzip cpptools-linux.vsix
cp /tmp/extension/debugAdapters/bin/* ~/.config/nvim/bin/vscode-cpptools/ 
chmod +x ~/.config/nvim/bin/vscode-cpptools/OpenDebugAD7

# pyenv for python dap
mkdir ~/.config/nvim/bin/virtualenvs
cd ~/.config/nvim/bin/virtualenvs && python -m venv debugpy && debugpy/bin/python -m pip install debugpy

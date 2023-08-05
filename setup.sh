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
### DAPs ###
# cpptools-linux: c, cpp, rust 
cd /tmp && wget https://github.com/microsoft/vscode-cpptools/releases/download/v1.16.3/cpptools-linux.vsix 
unzip cpptools-linux.vsix
cp /tmp/extension/debugAdapters/bin/* ~/.config/nvim/bin/vscode-cpptools/ 
chmod +x ~/.config/nvim/bin/vscode-cpptools/OpenDebugAD7
# debugpy: python
mkdir ~/.config/nvim/bin/virtualenvs
cd ~/.config/nvim/bin/virtualenvs/ && python -m venv debugpy && debugpy/bin/python -m pip install debugpy
### LSPs ###
# clangd
cd /tmp && wget https://github.com/clangd/clangd/releases/download/16.0.2/clangd-linux-16.0.2.zip
unzip clangd-linux-16.0.2.zip
cp /tmp/clangd_16.0.2/bin/clangd ~/.local/bin/
# luals
cd /tmp && git clone https://github.com/LuaLS/lua-language-server
cd /tmp/lua-language-server && ./make.sh
mkdir ~/.config/nvim/bin/lua_ls/
cp /tmp/lua-language-server/bin/* ~/.config/nvim/bin/lua_ls/
echo "/home/benjamin/.config/nvim/bin/lua_ls/lua-language-server" > ~/.local/bin/lua-language-server

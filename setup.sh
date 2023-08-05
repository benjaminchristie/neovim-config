#!/bin/sh

mkdir -p ~/.local/bin/

## basic dependencies
if [ -x "$(command -v paru)" ]
then
    paru -S --noconfirm bash-language-server glow bat clang clangd cmake-language-server dockerfile-language-server gcc gdb git gopls python-pip cargo fzf ninja
    cargo install asm-lsp
    # NVIM install
    git clone https://github.com/neovim/neovim.git /tmp/neovim
    cd /tmp/neovim/ && make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
    # NVIM config install
    git clone https://github.com/benjaminchristie/neovim-config ~/.config/nvim
    mkdir -p ~/.config/nvim/bin
    ### DAPs ###
    # cpptools-linux: c, cpp, rust 
    cd /tmp && wget https://github.com/microsoft/vscode-cpptools/releases/download/v1.16.3/cpptools-linux.vsix 
    unzip cpptools-linux.vsix
    cp /tmp/extension/debugAdapters/bin/* ~/.config/nvim/bin/vscode-cpptools/ 
    chmod +x ~/.config/nvim/bin/vscode-cpptools/OpenDebugAD7
    # debugpy: python
    mkdir ~/.config/nvim/bin/virtualenvs
    cd ~/.config/nvim/bin/virtualenvs/ && python -m venv debugpy && debugpy/bin/python -m pip install debugpy
elif [ -x "$(command -v apt)" ]
then
    apt update -yqq
    apt install -y --no-install-recommends python3-pip gcc gdb clang git sudo curl wget unzip tar ninja-build build-essential
    # fzf
    git clone https://github.com/junegunn/fzf /tmp/fzf
    cd /tmp/fzf/ && ./install --all
    cp /tmp/fzf/bin/fzf ~/.local/bin/
    # NVIM install
    git clone https://github.com/neovim/neovim.git /tmp/neovim
    cd /tmp/neovim/ && make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
    # NVIM config install
    git clone https://github.com/benjaminchristie/neovim-config ~/.config/nvim
    mkdir -p ~/.config/nvim/bin
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
else
    echo "paru or apt is not configured"
    return 1
fi
# directory configuration
# VIM-PLUG install
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

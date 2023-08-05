#!/bin/bash
print_style () {
    COLOR="91m";
    STARTCOLOR="\e[$COLOR";
    ENDCOLOR="\e[0m";

    printf "$STARTCOLOR%b$ENDCOLOR" "$1";
}

install_neovim() {
    # NVIM config install
    mkdir -p $HOME/.config/
    git clone https://github.com/benjaminchristie/neovim-config $HOME/.config/nvim
    mkdir -p $HOME/.config/nvim/bin
    # NVIM install: performed after config to avoid collisions
    git clone https://github.com/neovim/neovim.git /tmp/neovim && \
        cd /tmp/neovim/ && \
        make CMAKE_BUILD_TYPE=Release && \
        sudo make install
}
install_daps() {
    ### DAPs ###
    # cpptools-linux: c, cpp, rust 
    cd /tmp && \
        wget https://github.com/microsoft/vscode-cpptools/releases/download/v1.16.3/cpptools-linux.vsix --quiet && \
        unzip -q cpptools-linux.vsix && \
        mkdir -p $HOME/.config/nvim/bin/vscode-cpptools/ && \
        cp /tmp/extension/debugAdapters/bin/* $HOME/.config/nvim/bin/vscode-cpptools/ && \
        chmod +x $HOME/.config/nvim/bin/vscode-cpptools/OpenDebugAD7
    # debugpy: python
    mkdir -p $HOME/.config/nvim/bin/virtualenvs && \
        cd $HOME/.config/nvim/bin/virtualenvs/ && \
        python -m venv debugpy && \
        debugpy/bin/python -m pip install debugpy
}
install_lsps() {
    ### LSPs ###
    # clangd
    cd /tmp && \
        wget https://github.com/clangd/clangd/releases/download/16.0.2/clangd-linux-16.0.2.zip --quiet && \
        unzip -q clangd-linux-16.0.2.zip && \
        cp /tmp/clangd_16.0.2/bin/clangd $HOME/.local/bin/
    # luals
    cd /tmp && \
        git clone https://github.com/LuaLS/lua-language-server && \
        cd /tmp/lua-language-server && \
        ./make.sh && \
        mkdir -p $HOME/.config/nvim/bin/lua_ls/ && \
        cd $HOME/.config/nvim/bin/lua_ls/ && \
        cp -r /tmp/lua-language-server/* . && \
        echo 'exec "$HOME/.config/nvim/bin/lua_ls/bin/lua-language-server" "$@"' > $HOME/.local/bin/lua-language-server && \
        chmod +x $HOME/.local/bin/lua-language-server
    # bash-language-server
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash && \
        source $HOME/.bashrc && \
        PATH=$HOME/.local/bin:$PATH && \
        nvm install 18 && \
        nvm use 18 && \
        sudo npm i -g bash-language-server
    # pyright, cmake-language-server
    if ! pip install --ignore-installed pyright cmake-language-server
    then
        pip install --ignore-installed --break-system-packages pyright cmake-language-server
    fi
} 
# unused, since FZF is included in my vimplug configuration
install_fzf() {
    # fzf
    git clone https://github.com/junegunn/fzf /tmp/fzf && \
        cd /tmp/fzf/ && \
        ./install --key-bindings --completion --no-update-rc --bin && \
        cp /tmp/fzf/bin/fzf $HOME/.local/bin/
}
install_vimplug() {
    # VIM-PLUG install
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    nvim --headless +PlugInstall! +qall 2> /dev/null
}
install_linters() {
    # black-macchiato
    if ! pip install --ignore-installed black-macchiato
    then
        pip install --ignore-installed --break-system-packages black-macchiato
    fi
}

read -p "USE AT YOUR OWN RISK: Ensure you have paru or apt configured and press any button to continue: " dummy_var
mkdir -p ~/.local/bin/

print_style "Installing neovim dependencies: \n"

## install dependencies
if [ -x "$(command -v paru)" ]
then
    paru -S --noconfirm bash-language-server glow bat clang clangd cmake-language-server dockerfile-language-server gcc gdb git gopls python-pip cargo fzf ninja ripgrep
elif [ -x "$(command -v apt)" ]
then
    sudo apt update -yqq && \
        sudo apt install -y --no-install-recommends python3-pip gcc gdb clang git sudo curl wget unzip tar ninja-build build-essential cmake gettext npm cargo python-is-python3 python3-venv xclip ripgrep clang-format
else
    echo "paru or apt is not configured"
    return 1
fi

print_style "Installing neovim [Release] and benjaminchristie/neovim-config : \n"
install_neovim 
print_style "Installing neovim LSPs : \n"
install_lsps 
print_style "Installing neovim DAPs : \n"
install_daps 
print_style "Installing linters : \n"
install_linters
print_style "Installing vim-plug : \n"
install_vimplug 

# temporary configuration
PATH=$HOME/.local/bin:$PATH
FZF_DEFAULT_COMMAND='rg --hidden -l ""'
echo "export FZF_DEFAULT_COMMAND='rg --hidden -l \"\"'" >> $HOME/.bashrc

print_style "\n\nNeovim installation is complete! Note that some LSPs may not be installed. You may need to restart your shell for changes to take effect.\n"

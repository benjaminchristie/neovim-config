lua vim.loader.enable()
if exists('g:vscode')
    " VSCode extension
    lua vim.o.hlsearch = true
    lua vim.o.incsearch = true

    lua vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
    lua vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")
    lua vim.keymap.set('n', 'n', 'nzz')
    lua vim.keymap.set('n', 'N', 'Nzz')
    lua vim.keymap.set('n', '<C-d>', '<C-d>zz')
    lua vim.keymap.set('n', '<C-u>', '<C-u>zz')
    lua vim.keymap.set('n', '}', '}zz')
    lua vim.keymap.set('n', '{', '{zz')
    lua vim.keymap.set('n', '<Up>', '<C-b>')
    lua vim.keymap.set('n', '<Down>', '<C-f>')
    lua vim.keymap.set('n', '<Left>', 'gT')
    lua vim.keymap.set('n', '<Right>', 'gt')

    set noloadplugins


else

    call plug#begin()
    """ Internal plugins """
    " Essential
    Plug 'hrsh7th/nvim-cmp', { 'commit': '969c5a' }
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

    " LSP
    Plug 'L3MON4D3/LuaSnip'
    Plug 'folke/neodev.nvim'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-path'
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'michaelb/sniprun', { 'do': 'sh install.sh'}
    Plug 'simrat39/rust-tools.nvim', { 'for': 'rust' }
    Plug 'windwp/nvim-autopairs'
    Plug 'windwp/nvim-ts-autotag'
    " Plug 'uga-rosa/cmp-dictionary'
    Plug 'petertriho/cmp-git'

    " DAP
    Plug 'LiadOz/nvim-dap-repl-highlights'
    Plug 'Weissle/persistent-breakpoints.nvim'
    Plug 'leoluz/nvim-dap-go'
    Plug 'mfussenegger/nvim-dap'
    Plug 'mfussenegger/nvim-dap-python'
    Plug 'rcarriga/nvim-dap-ui'
    Plug 'theHamsta/nvim-dap-virtual-text'

    " Git
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'tpope/vim-fugitive'

    " File finders
    Plug 'ThePrimeagen/harpoon'
    Plug 'cljoly/telescope-repo.nvim'
    Plug 'ibhagwan/fzf-lua', { 'branch': 'main' }
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
    Plug 'stevearc/oil.nvim', { 'on': 'Oil' }

    " QoL
    Plug 'IMOKURI/line-number-interval.nvim'
    Plug 'ThePrimeagen/refactoring.nvim'
    Plug 'akinsho/toggleterm.nvim'
    Plug 'benjaminchristie/csgithub.nvim', { 'branch': 'master'}
    Plug 'chrisgrieser/nvim-early-retirement'
    Plug 'kevinhwang91/nvim-ufo'
    Plug 'kevinhwang91/promise-async'
    Plug 'kylechui/nvim-surround'
    Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'v3' }
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
    Plug 'rhysd/vim-clang-format', { 'on': 'ClangFormat', 'for': 'cpp' }
    Plug 't-troebst/perfanno.nvim'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-dispatch'
    Plug 'tpope/vim-eunuch'
    Plug 'tzachar/highlight-undo.nvim'
    Plug 'vladdoster/remember.nvim'

    " Accessory
    Plug 'benjaminchristie/mini.starter'
    Plug 'benjaminchristie/nvim-colorizer.lua', { 'on': 'ColorizerToggle' }
    Plug 'dstein64/vim-startuptime', { 'on': 'StartupTime' }
    Plug 'folke/tokyonight.nvim'
    Plug 'projekt0n/github-nvim-theme'
    Plug 'kosayoda/nvim-lightbulb'
    Plug 'chentoast/marks.nvim'
    Plug 'p00f/godbolt.nvim'


    """ External plugins """
    """ REQUIRES: node, pnpm, pip, dotnet-sdk """
    Plug 'junegunn/fzf', {  'do': './install --all --no-fish' }
    Plug 'LuaLS/lua-language-server',          { 'do': './make.sh && echo \"$HOME/.local/share/nvim/plugged/lua-language-server/bin/lua-language-server \"\$@\"\" > $HOME/.local/bin/lua-language-server && chmod +x $HOME/.local/bin/lua-language-server' }
    Plug 'tomblind/local-lua-debugger-vscode', { 'do': 'npm install && npm run build' }
    if executable('pnpm')
        Plug 'bash-lsp/bash-language-server',  { 'do': 'pnpm install && pnpm compile && npm i -g --prefix ./bin ./server && echo \"$HOME/.local/share/nvim/plugged/bash-language-server/bin/bin/bash-language-server \"\$@\"\" > $HOME/.local/bin/bash-language-server && chmod +x $HOME/.local/bin/bash-language-server' }
    endif
    if executable('dotnet')
        Plug 'artempyanykh/marksman',          { 'do': 'make install'}
    endif
    if executable('pip')
        Plug 'regen100/cmake-language-server', { 'do': '$HOME/.config/nvim/bin/pip-script.sh testresources cmake-language-server'}
        Plug 'RobertCraigie/pyright-python',   { 'do': '$HOME/.config/nvim/bin/pip-script.sh testresources pyright'}
        Plug 'wbolster/black-macchiato',       { 'do': '$HOME/.config/nvim/bin/pip-script.sh black-macchiato'}
    endif
    if executable('cargo')
        Plug 'latex-lsp/texlab',               { 'do': 'cargo build --release --color=never && cp ./target/release/texlab $HOME/.local/bin/'}
    endif

    """ Registering vim-plug provides help menus for vim-plug """
    Plug 'junegunn/vim-plug' 

    call plug#end()
endif

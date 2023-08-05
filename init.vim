if exists('g:vscode')
    " VSCode extension
    lua require("vscode-init")
else
    call plug#begin()
    """ Internal plugins """
    " Essential
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

    " LSP
    Plug 'L3MON4D3/LuaSnip'
    Plug 'folke/neodev.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'rhysd/vim-clang-format', { 'on': 'ClangFormat', 'for': 'cpp' }
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'simrat39/rust-tools.nvim', { 'for': 'rust' }
    Plug 'windwp/nvim-autopairs'
    Plug 'windwp/nvim-ts-autotag'

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
    Plug 'tpope/vim-fugitive', { 'on': [ 'G', 'Git' ]}

    " File finders
    Plug 'ThePrimeagen/harpoon'
    Plug 'cljoly/telescope-repo.nvim'
    Plug 'ibhagwan/fzf-lua', { 'branch': 'main' }
    Plug 'kyazdani42/nvim-web-devicons', { 'on': 'Oil' }
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
    Plug 'stevearc/oil.nvim', { 'on': 'Oil' }

    " QoL
    Plug 'IMOKURI/line-number-interval.nvim'
    Plug 'Shatur/neovim-tasks'
    Plug 'ThePrimeagen/refactoring.nvim'
    Plug 'akinsho/toggleterm.nvim'
    Plug 'benjaminchristie/csgithub.nvim', { 'branch': 'master'}
    Plug 'ethanholz/nvim-lastplace'
    Plug 'kevinhwang91/nvim-ufo'
    Plug 'kevinhwang91/promise-async'
    Plug 'kylechui/nvim-surround'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
    Plug 't-troebst/perfanno.nvim'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-dispatch', { 'on': 'Dispatch' }
    Plug 'tpope/vim-eunuch'

    " Accessory
    Plug 'benjaminchristie/nvim-colorizer.lua'
    Plug 'dstein64/vim-startuptime', { 'on': 'StartupTime' }
    Plug 'echasnovski/mini.starter'
    Plug 'folke/tokyonight.nvim'


    """ External plugins """
    Plug 'junegunn/fzf', { 'dir': '$HOME/.config/nvim/bin/fzf', 'do': './install --all --no-fish' }

    """ Registering vim-plug provides help menus for vim-plug """
    Plug 'junegunn/vim-plug' 

    call plug#end()
    lua require('init')
endif

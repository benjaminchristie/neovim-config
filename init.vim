if exists('g:vscode')
    " VSCode extension
    lua require("vscode-init")
else
    call plug#begin()
    Plug 'akinsho/toggleterm.nvim'
    Plug 'benjaminchristie/csgithub.nvim', {'branch': 'master'}
    Plug 'benjaminchristie/nvim-colorizer.lua'
    Plug 'cljoly/telescope-repo.nvim'
    Plug 'echasnovski/mini.starter'
    Plug 'ethanholz/nvim-lastplace'
    Plug 'folke/tokyonight.nvim'
    Plug 'folke/neodev.nvim'
    Plug 'mfussenegger/nvim-dap'
    Plug 'mfussenegger/nvim-dap-python'
    Plug 'leoluz/nvim-dap-go'
    Plug 'theHamsta/nvim-dap-virtual-text'
    Plug 'rcarriga/nvim-dap-ui'
    Plug 'LiadOz/nvim-dap-repl-highlights'
    Plug 'Weissle/persistent-breakpoints.nvim'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'IMOKURI/line-number-interval.nvim'
    Plug 'kevinhwang91/nvim-ufo'
    Plug 'kevinhwang91/promise-async'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kylechui/nvim-surround'
    Plug 'lambdalisue/suda.vim'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'mbbill/undotree'
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'rhysd/vim-clang-format'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'simrat39/rust-tools.nvim'
    Plug 'stevearc/oil.nvim'
    Plug 'Shatur/neovim-tasks'
    Plug 't-troebst/perfanno.nvim'
    Plug 'ThePrimeagen/harpoon'
    Plug 'ThePrimeagen/refactoring.nvim'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-dispatch'
    Plug 'windwp/nvim-autopairs'
    Plug 'windwp/nvim-ts-autotag'
    call plug#end()
    lua require('init')
endif

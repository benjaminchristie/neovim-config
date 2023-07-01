if exists('g:vscode')

    call plug#begin()
    Plug 'kylechui/nvim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-commentary'

    call plug#end()
    " VSCode extension
else
    call plug#begin()
    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'kevinhwang91/nvim-ufo'
    Plug 'kevinhwang91/promise-async'
    Plug 'nvim-lua/popup.nvim'
    Plug 'cljoly/telescope-repo.nvim'
    Plug 'echasnovski/mini.pairs'
    Plug 'echasnovski/mini.starter'
    Plug 'ThePrimeagen/harpoon'
    Plug 'ThePrimeagen/refactoring.nvim'
    Plug 'sakhnik/nvim-gdb', {'do': ':!./install.sh'}
    Plug 'benjaminchristie/csgithub.nvim', {'branch': 'master'}
    Plug 'benjaminchristie/nvim-colorizer.lua'
    Plug 't-troebst/perfanno.nvim'
    Plug 'rhysd/vim-clang-format'
    Plug 'Shatur/neovim-tasks'
    Plug 'akinsho/toggleterm.nvim'
    Plug 'da-moon/telescope-toggleterm.nvim'
    Plug 'debugloop/telescope-undo'
    Plug 'nvim-telescope/telescope-media-files.nvim'
    Plug 'mbbill/undotree'
    Plug 'lambdalisue/suda.vim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'JellyApple102/easyread.nvim'
    Plug 'kylechui/nvim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'tpope/vim-commentary'
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'stevearc/oil.nvim'
    Plug 'godlygeek/tabular'
    Plug 'ethanholz/nvim-lastplace'
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'simrat39/rust-tools.nvim'
    Plug 'mcchrish/zenbones.nvim'
    Plug 'rktjmp/lush.nvim'
    Plug 'tanvirtin/monokai.nvim'
    Plug 'folke/tokyonight.nvim'
    Plug 'navarasu/onedark.nvim'
    Plug 'tiagovla/tokyodark.nvim'
    call plug#end()
    lua require('init')
endif

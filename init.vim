if exists('g:vscode')

    call plug#begin()
    Plug 'kylechui/nvim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-commentary'

    call plug#end()
    " VSCode extension
else
    call plug#begin()
    Plug 'cljoly/telescope-repo.nvim'
    Plug 'echasnovski/mini.pairs'
    Plug 'echasnovski/mini.starter'
    Plug 'ThePrimeagen/harpoon'
    Plug 'ThePrimeagen/refactoring.nvim'
    Plug 'sakhnik/nvim-gdb', {'do': ':!./install.sh'}
    "
    " Plug 'Vimjas/vim-python-pep8-indent'
    " Plug 'jbyuki/nabla.nvim'
    Plug 'benjaminchristie/csgithub.nvim', {'branch': 'master'}
    Plug 'rhysd/vim-clang-format'
    Plug 'Shatur/neovim-tasks'
    Plug 'akinsho/toggleterm.nvim'
    Plug 'da-moon/telescope-toggleterm.nvim'
    Plug 'debugloop/telescope-undo'
    Plug 'mbbill/undotree'
    Plug 'lambdalisue/suda.vim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'norcalli/nvim-colorizer.lua'
    " Plug 'vim-airline/vim-airline'
    " Plug 'vim-airline/vim-airline-themes'
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'JellyApple102/easyread.nvim'
    "( Tm Pope plugins
    Plug 'kylechui/nvim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-commentary'
    Plug 'lewis6991/gitsigns.nvim'
    "( Cmpletion plugins
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    ""( Vnip
    "Plug 'hrsh7th/cmp-vsnip'
    "Plug 'hrsh7th/vim-vsnip'
    "( Msc nice plugins
    " Plug 'Pocco81/true-zen.nvim'
    Plug 'lewis6991/impatient.nvim'
    Plug 'godlygeek/tabular'
    Plug 'ethanholz/nvim-lastplace'
    " Testing
    Plug 'L3MON4D3/LuaSnip'
    Plug 'saadparwaiz1/cmp_luasnip'
    "( Tlescope )
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    "( Nim File tree
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'simrat39/rust-tools.nvim'
    "( Vrious Themes
    Plug 'mcchrish/zenbones.nvim'
    Plug 'rktjmp/lush.nvim'
    Plug 'tanvirtin/monokai.nvim'
    Plug 'folke/tokyonight.nvim'
    Plug 'navarasu/onedark.nvim'
    Plug 'tiagovla/tokyodark.nvim'
    Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
    " Plug 'Yggdroot/indentLine'
    call plug#end()
    lua require('init')
endif

" filetype plugin on
" autocmd FileType python setlocal noexpandtab shiftwidth=4 softtabstop=4
"
" let g:python_recommended_style = 0


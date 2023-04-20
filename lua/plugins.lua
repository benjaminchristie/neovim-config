Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.local/share/nvim/plugged/')
Plug( 'feline-nvim/feline.nvim')
Plug( 'neovim/nvim-lspconfig')
Plug( 'vim-airline/vim-airline')
Plug( 'vim-airline/vim-airline-themes')
Plug( 'nvim-treesitter/nvim-treesitter')
Plug( 'tpope/vim-surround')
Plug( 'tpope/vim-fugitive')
Plug( 'tpope/vim-commentary')
Plug( 'hrsh7th/cmp-nvim-lsp')
Plug( 'hrsh7th/cmp-buffer')
Plug( 'hrsh7th/cmp-path')
Plug( 'hrsh7th/cmp-cmdline')
Plug( 'hrsh7th/nvim-cmp')
Plug( 'hrsh7th/cmp-vsnip')
Plug( 'hrsh7th/vim-vsnip')
Plug( 'Pocco81/true-zen.nvim')
Plug( 'shaunsingh/nord.nvim')
Plug( 'godlygeek/tabular')
Plug( 'preservim/vim-markdown')
Plug( 'ethanholz/nvim-lastplace')
Plug( 'nvim-lua/plenary.nvim')
Plug( 'nvim-telescope/telescope.nvim', { branch = '0.1.x' })
Plug( 'kyazdani42/nvim-web-devicons' )
Plug( 'kyazdani42/nvim-tree.lua')
Plug( 'mcchrish/zenbones.nvim')
Plug( 'rktjmp/lush.nvim')
Plug( 'tanvirtin/monokai.nvim')
vim.call('plug#end')

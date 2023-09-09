# neovim-config

Table of plugins (last updated 09 September 2023), ranked in order of importance (approximately).

| Plugin | Usage |
| ------ | ----- |
| hrsh7th/nvim-cmp | Completion |
| neovim/nvim-lspconfig | Configuring LSP |
| nvim-lua/plenary.nvim | Asynchronous utils |
| nvim-lua/popup.nvim | Required for various plugins |
| nvim-treesitter/nvim-treesitter | Configuring treesitter |
| folke/neodev.nvim | Exposes neovim functions to LuaLS |
| L3MON4D3/LuaSnip | Snippet engine |
| hrsh7th/cmp-buffer | Completion provider |
| hrsh7th/cmp-cmdline | Completion provider |
| hrsh7th/cmp-nvim-lsp | Completion provider |
| hrsh7th/cmp-path | Completion provider |
| petertriho/cmp-git | Completion provider |
| nvim-treesitter/nvim-treesitter-textobjects | Utils for treesitter |
| michaelb/sniprun | :SnipRun commands |
| simrat39/rust-tools.nvim | Various rust tools |
| windwp/nvim-autopairs | Provides custom pair functionality in text |
| windwp/nvim-ts-autotag | Autotag for html / xml |
| LiadOz/nvim-dap-repl-highlights | Provides highlights in DAP REPL |
| Weissle/persistent-breakpoints.nvim | Persistent breakpoints between nvim instances |
| mfussenegger/nvim-dap | DAP |
| rcarriga/nvim-dap-ui | DAP ui |
| leoluz/nvim-dap-go | DAP provider for golang |
| mfussenegger/nvim-dap-python | DAP provider for debugpy |
| tpope/vim-fugitive | So powerful it feels illegal |
| lewis6991/gitsigns.nvim | Provides various git utils, including a gutter |
| ThePrimeagen/harpoon | Easily navigate between hot buffers |
| ibhagwan/fzf-lua | File finder |
| kyazdani42/nvim-web-devicons | Exposes icons for various plugins |
| stevearc/oil.nvim | File navigation |
| IMOKURI/line-number-interval.nvim | Nice highlights for line numbers |
| akinsho/toggleterm.nvim | Provides an interface for toggling terminals |
| benjaminchristie/csgithub.nvim | Search for text in github |
| chrisgrieser/nvim-early-retirement | Close stale buffers |
| itchyny/vim-qfedit | Edit the qf list |
| kevinhwang91/nvim-ufo | Fold provider, much better than default folding |
| kevinhwang91/promise-async | Dependency of nvim-ufo |
| kylechui/nvim-surround | FANTASTIC surround text utils |
| lukas-reineke/indent-blankline.nvim | Indent blankline virtual text |
| mbbill/undotree | Display and manipulate the undo-tree |
| nguyenvukhang/nvim-toggler | Toggle text on a dime |
| sindrets/diffview.nvim | Fantastic diff analysis via git |
| t-troebst/perfanno.nvim | Analyze recorded perf data |
| tpope/vim-commentary | Comment code |
| tpope/vim-dispatch | Useful for Make, Build, etc. |
| tpope/vim-eunuch | Exposes linux programs; exposes Delete, etc. |
| tpope/vim-repeat | Optional dependency of some plugins |
| tzachar/highlight-undo.nvim | Highlight "undone" text |
| tzachar/local-highlight.nvim | Highlight words that match the <cword> |
| VidocqH/lsp-lens.nvim | **TODO**: evaluate if necessary |
| benjaminchristie/mini.starter | Startup screen (my fork) |
| benjaminchristie/nvim-colorizer.lua | Colorize hex codes (my fork) |
| dstein64/vim-startuptime | Analyze vi startuptime |
| folke/tokyonight.nvim | Colorscheme |
| kosayoda/nvim-lightbulb | Provides a lightbulb in the gutter when code-actions are available |
| p00f/godbolt.nvim | Analyze assembled code |

The following are plugins that are not directly used by vim, but are managed by vim-plug for ease-of-use and autonomy.

| External Plugins | Use case |
| ---  | --- |
| junegunn/fzf | Misc. finder |
| LuaLS/lua-language-server | LuaLS |
| tomblind/local-lua-debugger-vscode | Debugger for LuaLS. Requires bin/nlua.lua |
| bash-lsp/bash-language-server | BashLS |
| artempyanykh/marksman | Markdown LS |
| regen100/cmake-language-server | CMake LS |
| RobertCraigie/pyright-python | Python LS |
| wbolster/black-macchiato | Python formatter |
| latex-lsp/texlab | TEX / LaTeX LS |
| junegunn/vim-plug | Including this file in vim-plug exposes the help menu for vim-plug |

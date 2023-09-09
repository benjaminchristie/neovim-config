# neovim-config

This configuration of `neovim` can be used on arch or ubuntu. See `bin/setup.sh` for details. 

## Bin

`bin/` includes the following files:

- `nlua.lua`: needed for debugging lua code via DAP
- `pip-script.sh`: used for installing some dependencies, see [Plugins](##Plugins)
- `setup.sh`: setup neovim on a new machine (works on arch via paru or on ubuntu via apt). Use at your own risk, read the entire script before running.

Additionally, some plugins managed by vim-plug install programs in `bin/`. Typically, the folder can be left untouched. 

The `setup.sh` script assumes that the user has a `~/.local/bin` folder that is included in `$PATH`. If not, one is created. 

## Plugins

Vim-plug is used to install and manage plugins. See the table below for details: (last updated 09 September 2023), ranked in order of importance (approximately).

| Plugin | Usage |
| ------ | ----- |
| [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion |
| [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Configuring LSP |
| [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Asynchronous utils |
| [nvim-lua/popup.nvim](https://github.com/nvim-lua/popup.nvim) | Required for various plugins |
| [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Configuring treesitter |
| [folke/neodev.nvim](https://github.com/folke/neodev.nvim) | Exposes neovim functions to LuaLS |
| [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer) | Completion provider |
| [hrsh7th/cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline) | Completion provider |
| [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | Completion provider |
| [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path) | Completion provider |
| [petertriho/cmp-git](https://github.com/petertriho/cmp-git) | Completion provider |
| [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) | Utils for treesitter |
| [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Colorscheme |
| [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive) | A git wrapper so awesome, it should be illegal |
| [tpope/vim-commentary](https://github.com/tpope/vim-commentary) | Comment code |
| [tpope/vim-dispatch](https://github.com/tpope/vim-dispatch) | Useful for Make, Build, etc. |
| [tpope/vim-eunuch](https://github.com/tpope/vim-eunuch) | Exposes linux programs; exposes Delete, etc. |
| [tpope/vim-repeat](https://github.com/tpope/vim-repeat) | Optional dependency of some plugins |
| [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Provides various git utils, including a gutter |
| [sindrets/diffview.nvim](https://github.com/sindrets/diffview.nvim) | Fantastic diff analysis via git |
| [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap) | DAP |
| [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | DAP ui |
| [leoluz/nvim-dap-go](https://github.com/leoluz/nvim-dap-go) | DAP provider for golang |
| [mfussenegger/nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) | DAP provider for debugpy |
| [Weissle/persistent-breakpoints.nvim](https://github.com/Weissle/persistent-breakpoints.nvim) | Persistent breakpoints between nvim instances |
| [LiadOz/nvim-dap-repl-highlights](https://github.com/LiadOz/nvim-dap-repl-highlights) | Provides highlights in DAP REPL |
| [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Provides custom pair functionality in text |
| [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) | Autotag for html / xml |
| [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua) | File finder |
| [stevearc/oil.nvim](https://github.com/stevearc/oil.nvim) | File navigation |
| [kyazdani42/nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons) | Exposes icons for various plugins |
| [itchyny/vim-qfedit](https://github.com/itchyny/vim-qfedit) | Edit the qf list |
| [kylechui/nvim-surround](https://github.com/kylechui/nvim-surround) | FANTASTIC surround text utils |
| [akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Provides an interface for toggling terminals |
| [michaelb/sniprun](https://github.com/michaelb/sniprun) | :SnipRun commands |
| [ThePrimeagen/harpoon](https://github.com/ThePrimeagen/harpoon) | Easily navigate between hot buffers |
| [IMOKURI/line-number-interval.nvim](https://github.com/IMOKURI/line-number-interval.nvim) | Nice highlights for line numbers |
| [benjaminchristie/csgithub.nvim](https://github.com/benjaminchristie/csgithub.nvim) | Search for text in github |
| [chrisgrieser/nvim-early-retirement](https://github.com/chrisgrieser/nvim-early-retirement) | Close stale buffers |
| [kevinhwang91/nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) | Fold provider, much better than default folding |
| [kevinhwang91/promise-async](https://github.com/kevinhwang91/promise-async) | Dependency of nvim-ufo |
| [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indent blankline virtual text |
| [mbbill/undotree](https://github.com/mbbill/undotree) | Display and manipulate the undo-tree |
| [nguyenvukhang/nvim-toggler](https://github.com/nguyenvukhang/nvim-toggler) | Toggle text on a dime |
| [t-troebst/perfanno.nvim](https://github.com/t-troebst/perfanno.nvim) | Analyze recorded perf data |
| [tzachar/highlight-undo.nvim](https://github.com/tzachar/highlight-undo.nvim) | Highlight "undone" text |
| [tzachar/local-highlight.nvim](https://github.com/tzachar/local-highlight.nvim) | Highlight words that match the \<cword\> |
| [VidocqH/lsp-lens.nvim](https://github.com/VidocqH/lsp-lens.nvim) | **TODO**: evaluate if necessary |
| [benjaminchristie/mini.starter](https://github.com/benjaminchristie/mini.starter) | Startup screen (my fork) |
| [benjaminchristie/nvim-colorizer.lua](https://github.com/benjaminchristie/nvim-colorizer.lua) | Colorize hex codes (my fork) |
| [dstein64/vim-startuptime](https://github.com/dstein64/vim-startuptime) | Analyze vi startuptime |
| [kosayoda/nvim-lightbulb](https://github.com/kosayoda/nvim-lightbulb) | Provides a lightbulb in the gutter when code-actions are available |
| [p00f/godbolt.nvim](https://github.com/p00f/godbolt.nvim) | Analyze assembled code |
| [simrat39/rust-tools.nvim](https://github.com/simrat39/rust-tools.nvim) | Various rust tools |

### External plugins

The following are plugins that are not directly used by vim, but are managed by vim-plug for ease-of-use and autonomy.

| External Plugins | Use case |
| ---  | --- |
| [junegunn/fzf](https://github.com/junegunn/fzf) | Misc. finder |
| [LuaLS/lua-language-server](https://github.com/LuaLS/lua-language-server) | LuaLS |
| [tomblind/local-lua-debugger-vscode](https://github.com/tomblind/local-lua-debugger-vscode) | Debugger for LuaLS. Requires bin/nlua.lua |
| [bash-lsp/bash-language-server](https://github.com/bash-lsp/bash-language-server) | BashLS |
| [artempyanykh/marksman](https://github.com/artempyanykh/marksman) | Markdown LS |
| [regen100/cmake-language-server](https://github.com/regen100/cmake-language-server) | CMake LS |
| [RobertCraigie/pyright-python](https://github.com/RobertCraigie/pyright-python) | Python LS |
| [wbolster/black-macchiato](https://github.com/wbolster/black-macchiato) | Python formatter |
| [latex-lsp/texlab](https://github.com/latex-lsp/texlab) | TEX / LaTeX LS |
| [junegunn/vim-plug](https://github.com/junegunn/vim-plug) | Including this file in vim-plug exposes the help menu for vim-plug |

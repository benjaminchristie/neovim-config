---
colorlinks: true
---
# neovim-config

This configuration of `neovim` can be used on arch or ubuntu. See `bin/setup.sh` for details. 

## Bin

`bin/` includes the following files:

- `nlua.lua`: needed for debugging lua code via DAP
- `pip-script.sh`: used for installing some dependencies, see [Plugins](##Plugins)
- `setup.sh`: only use if you know what you are doing

## Custom Functions

Several custom functions are exposed to global scope (or used in keybindings):

| Custom Functions | Use |
| :--- | :--- |
| `whereami` | shows the current cursor location by fading the column and row |
| various build tools | an extension of tpope's `vim-dispatch` plugin |
| `lazyload` | lazily load the theme and LSP of large files to spread the load over a longer duration |
| `MarkdownPreview` | uses `pandoc` and `zathura` to render a compiled markdown file in realtime |
| `ToggleZen` | basic "zen" mode |
| `Skeletons` | fuzzy find over skeletons for various filetypes. when opening a **new** file, the file is autofilled with various content depending on the filetype |
| `cd_to_file` | keybinding to cd to file in current buffer |
| `increment_search`/`decrement_search` | functions to navigate page *while fading the current search highlight* |
| `find_and_replace_all_cword` | the function name speaks for itself |
| `on_demand_autogroup` | create an autogroup command on demand. I used this frequently when i needed to run `:Make` every save, but didn't want this to apply generally |


## Plugins

Some of these plugins are managed by lazy, but are not directly used by neovim (e.g., LSPs and linters).

| Internal Plugins | Use |
| :--- | :--- |
| [aerial.nvim](https://github.com/stevearc/aerial.nvim) | Side buffer with LSP + treesitter info (functions, classes, etc.) |
| [cmp-buffer](https://github.com/hrsh7th/cmp-buffer) | nvim-cmp source for buffer words |
| [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline) | nvim-cmp source for the cmdline |
| [cmp-git](https://github.com/petertriho/cmp-git) | nvim-cmp source for git (used in git commits and cmdline) |
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | nvim-cmp source for LSP |
| [cmp-path](https://github.com/hrsh7th/cmp-path) | nvim-cmp source for (relative) path |
| [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) | nvim-cmp interface with LuaSnip engine + snippets |
| [csgithub.nvim](https://github.com/benjaminchristie/csgithub.nvim) | keybinding to search for <cword> in github |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim) | useful git interface, overkill for most applications. useful for git repo history |
| [fidget.nvim](https://github.com/j-hui/fidget.nvim) | LSP loading info |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | collection of snippets for various languages |
| [fzf-lua](https://github.com/ibhagwan/fzf-lua) | lua interface for FZF fuzzy finder |
| [github-nvim-theme](https://github.com/projekt0n/github-nvim-theme) | (rarely used) color scheme |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | git buffer integration |
| [godbolt.nvim](https://github.com/p00f/godbolt.nvim) | query [Compiler Explorer](https://www.godbolt.org) for compiled code in assembly of current buffer; show results in vertical split |
| [harpoon](https://github.com/ThePrimeagen/harpoon) | unused (and unloaded) file selector, not useful for me |
| [highlight-undo.nvim](https://github.com/tzachar/highlight-undo.nvim) | highlights {un,re}do |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | indents the blankline! |
| lazy.nvim | plugin manager and loading scheduler |
| [line-number-interval.nvim](https://github.com/IMOKURI/line-number-interval.nvim) | change the color of the line number interval. unused (and unloaded) as of now |
| [local-highlight.nvim](https://github.com/tzachar/local-highlight.nvim) | highlights matching <cword>s  |
| [lsp-lens.nvim](https://github.com/VidocqH/lsp-lens.nvim) | displays reference counts, etc. inline (along with inlay hints, when enabled)  |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | snippet engine |
| [lush.nvim](https://github.com/rktjmp/lush.nvim) | prereq for some colorschemes |
| [mini.starter](https://github.com/benjaminchristie/mini.starter) | startup screen |
| [neodev.nvim](https://github.com/folke/neodev.nvim) | interface lua-language-server with neovim documentation |
| [numb.nvim](https://github.com/nacro90/numb.nvim) | peeks the buffer when calling `:<number>`  |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | useful pairs plugin, allows custom pairs |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | completion engine |
| [nvim-colorizer.lua](https://github.com/benjaminchristie/nvim-colorizer.lua) | displays hex code colors with corresponding colored background |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) | DAP plugin |
| [nvim-dap-go](https://github.com/leoluz/nvim-dap-go) | DAP for golang |
| [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) | DAP for python (requires additional configuration, see `setup.sh`) |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | prettier DAP user interface |
| [nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text) | display DAP virtual text inline |
| [nvim-early-retirement](https://github.com/chrisgrieser/nvim-early-retirement) | close buffers that have been "ghosted" for a certain amount of time |
| [nvim-fundo](https://github.com/kevinhwang91/nvim-fundo) | forever undo, even when a file is edited *outside of neovim* |
| [nvim-lightbulb](https://github.com/kosayoda/nvim-lightbulb) | show a code action lightbulb in the colorcolumn, like in vscode. currently disabled |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | interface for configuring LSPs |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | `ysiw`, need i say more |
| [nvim-toggler](https://github.com/nguyenvukhang/nvim-toggler) | (silly) plugin, toggle text. requires hardcoding "opposite" values |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | no introduction necessary |
| [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) | operate on treesitter objects like they were text (delete function, ci function, etc.) |
| [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) | useful completion engine for HTML, YAML, XML |
| [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) | visualize folds differently |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | icons for neovim |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | **the best** file explorer |
| [onedark.nvim](https://github.com/navarasu/onedark.nvim) | my favorite neovim theme |
| [perfanno.nvim](https://github.com/t-troebst/perfanno.nvim) | visualize the results of `perf` or `python-perf` for C, CPP, and rust binaries. Also works with python 3.12+ |
| [persistent-breakpoints.nvim](https://github.com/Weissle/persistent-breakpoints.nvim) | persist breakpoints between neovim sessions for DAP ui |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | asynch library |
| [promise-async](https://github.com/kevinhwang91/promise-async) | prereq for UFO |
| [remember.nvim](https://github.com/vladdoster/remember.nvim) | like `vim-lastplace`, but written in lua |
| [rust-tools.nvim](https://github.com/simrat39/rust-tools.nvim) | useful rust presets and tools  |
| [smartcolumn.nvim](https://github.com/benjaminchristie/smartcolumn.nvim) | hides your colorcolumn when unneeded. surprisingly useful! |
| [sniprun](https://github.com/michaelb/sniprun) | run selected code and visualize the results inline |
| [swenv.nvim](https://github.com/AckslD/swenv.nvim) | change the python venv without leaving neovim |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | terminal interface, not used very much |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | (rarely used) colorscheme |
| [undotree](https://github.com/mbbill/undotree) | visualize the vim undo-tree |
| [unicode.vim](https://github.com/chrisbra/unicode.vim) | insert unicode characters on demand. useful for markdown files |
| [vim-boring](https://github.com/t184256/vim-boring) | boring colorscheme |
| [vim-commentary](https://github.com/tpope/vim-commentary) | all praise tpope |
| [vim-dispatch](https://github.com/tpope/vim-dispatch) | all praise tpope |
| [vim-eunuch](https://github.com/tpope/vim-eunuch) | all praise tpope |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | all praise tpope |
| [vim-qfedit](https://github.com/itchyny/vim-qfedit) | edit the qf list like a text buffer |
| [vim-repeat](https://github.com/tpope/vim-repeat) | all praise tpope |
| [vim-startuptime](https://github.com/dstein64/vim-startuptime) | benchmark vim startuptime performance. Unused and unloaded |
| [zenbones.nvim](https://github.com/mcchrish/zenbones.nvim) | (often used) collection of colorschemes |

| External Plugins | Use |
| :--- | :--- |
| [bash-language-server](https://github.com/bash-lsp/bash-language-server) | external plugin, managed by lazy. |
| [black-macchiato](https://github.com/wbolster/black-macchiato) | external plugin (python linter), managed by lazy. |
| [cmake-language-server](https://github.com/regen100/cmake-language-server) | external plugin, managed by lazy. |
| [fzf](https://github.com/junegunn/fzf) | external plugin (fuzzy finder), managed by lazy. |
| [local-lua-debugger-vscode](https://github.com/tomblind/local-lua-debugger-vscode) | external plugin, managed by lazy |
| [lua-language-server:d912dfc0](https://github.com/LuaLS/lua-language-server/commit/d912dfc05636ca113eb074d637905f4b2514229d) | external plugin, managed by lazy |
| [marksman](https://github.com/artempyanykh/marksman) | external plugin (markdown LSP), managed by lazy. |
| [pyright-python](https://github.com/RobertCraigie/pyright-python) | external plugin (python LSP), managed by lazy |
| [texlab](https://github.com/latex-lsp/texlab) | external plugin (\LaTeX \ LSP) managed by lazy |

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
| aerial.nvim | Side buffer with LSP + treesitter info (functions, classes, etc.) |
| cmp-buffer | nvim-cmp source for buffer words |
| cmp-cmdline | nvim-cmp source for the cmdline |
| cmp-git | nvim-cmp source for git (used in git commits and cmdline) |
| cmp-nvim-lsp | nvim-cmp source for LSP |
| cmp-path | nvim-cmp source for (relative) path |
| cmp_luasnip | nvim-cmp interface with LuaSnip engine + snippets |
| csgithub.nvim | keybinding to search for <cword> in github |
| diffview.nvim | useful git interface, overkill for most applications. useful for git repo history |
| fidget.nvim | LSP loading info |
| friendly-snippets | collection of snippets for various languages |
| fzf-lua | lua interface for FZF fuzzy finder |
| github-nvim-theme | (rarely used) color scheme |
| gitsigns.nvim | git buffer integration |
| godbolt.nvim | query [Compiler Explorer](https://www.godbolt.org) for compiled code in assembly of current buffer; show results in vertical split |
| harpoon | unused (and unloaded) file selector, not useful for me |
| highlight-undo.nvim | highlights {un,re}do |
| indent-blankline.nvim | indents the blankline! |
| lazy.nvim | plugin manager and loading scheduler |
| line-number-interval.nvim | change the color of the line number interval. unused (and unloaded) as of now |
| local-highlight.nvim | highlights matching <cword>s  |
| lsp-lens.nvim | displays reference counts, etc. inline (along with inlay hints, when enabled)  |
| LuaSnip | snippet engine |
| lush.nvim | prereq for some colorschemes |
| mini.starter | startup screen |
| neodev.nvim | interface lua-language-server with neovim documentation |
| numb.nvim | peeks the buffer when calling `:<number>`  |
| nvim-autopairs | useful pairs plugin, allows custom pairs |
| nvim-cmp | completion engine |
| nvim-colorizer.lua | displays hex code colors with corresponding colored background |
| nvim-dap | DAP plugin |
| nvim-dap-go | DAP for golang |
| nvim-dap-python | DAP for python (requires additional configuration, see `setup.sh`) |
| nvim-dap-ui | prettier DAP user interface |
| nvim-dap-virtual-text | display DAP virtual text inline |
| nvim-early-retirement | close buffers that have been "ghosted" for a certain amount of time |
| nvim-fundo | forever undo, even when a file is edited *outside of neovim* |
| nvim-lightbulb | show a code action lightbulb in the colorcolumn, like in vscode. currently disabled |
| nvim-lspconfig | interface for configuring LSPs |
| nvim-surround | `ysiw`, need i say more |
| nvim-toggler | (silly) plugin, toggle text. requires hardcoding "opposite" values |
| nvim-treesitter | no introduction necessary |
| nvim-treesitter-textobjects | operate on treesitter objects like they were text (delete function, ci function, etc.) |
| nvim-ts-autotag | useful completion engine for HTML, YAML, XML |
| nvim-ufo | visualize folds differently |
| nvim-web-devicons | icons for neovim |
| oil.nvim | **the best** file explorer |
| onedark.nvim | my favorite neovim theme |
| perfanno.nvim | visualize the results of `perf` or `python-perf` for C, CPP, and rust binaries. Also works with python 3.12+ |
| persistent-breakpoints.nvim | persist breakpoints between neovim sessions for DAP ui |
| plenary.nvim | asynch library |
| promise-async | prereq for UFO |
| remember.nvim | like `vim-lastplace`, but written in lua |
| rust-tools.nvim | useful rust presets and tools  |
| smartcolumn.nvim | hides your colorcolumn when unneeded. surprisingly useful! |
| sniprun | run selected code and visualize the results inline |
| swenv.nvim | change the python venv without leaving neovim |
| toggleterm.nvim | terminal interface, not used very much |
| tokyonight.nvim | (rarely used) colorscheme |
| undotree | visualize the vim undo-tree |
| unicode.vim | insert unicode characters on demand. useful for markdown files |
| vim-boring | all praise tpope |
| vim-commentary | all praise tpope |
| vim-dispatch | all praise tpope |
| vim-eunuch | all praise tpope |
| vim-fugitive | all praise tpope |
| vim-qfedit | all praise tpope |
| vim-repeat | all praise tpope |
| vim-startuptime | benchmark vim startuptime performance. Unused and unloaded |
| zenbones.nvim | (often used) collection of colorschemes |

| External Plugins | Use |
| :--- | :--- |
| bash-language-server | external plugin, managed by lazy. |
| black-macchiato | external plugin (python linter), managed by lazy. |
| cmake-language-server | external plugin, managed by lazy. |
| fzf | external plugin (fuzzy finder), managed by lazy. |
| local-lua-debugger-vscode | external plugin, managed by lazy |
| lua-language-server | external plugin, managed by lazy |
| marksman | external plugin (markdown LSP), managed by lazy. |
| pyright-python | external plugin (python LSP), managed by lazy |
| texlab | external plugin (\LaTeX \ LSP) managed by lazy |

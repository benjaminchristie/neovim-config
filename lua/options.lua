vim.g.loaded_2html_plugin = 0
vim.g.loaded_gzip = 0
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_spec = 1
vim.g.loaded_tar = 0
vim.g.loaded_tarPlugin = 0
vim.g.loaded_zipPlugin = 0
vim.g.syntastic_auto_jump = 1
vim.g.term_buf = 0
vim.g.term_win = 0
vim.g.editorconfig_trim_trailing_whitespace = true
vim.o.autoindent = true
vim.o.backup = false
vim.o.ch = 1
vim.o.clipboard = "unnamedplus"
vim.o.conceallevel = 0
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldenable = true
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.hlsearch = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ls = 0
vim.o.mouse = "inv"
vim.o.number = true
vim.o.path = vim.o.path .. "**"
vim.o.relativenumber = true
vim.o.shiftwidth = 4
vim.o.showcmd = true
vim.o.signcolumn = "yes:1"
vim.o.so = 0
vim.o.softtabstop = 8
vim.o.sol = false
vim.o.spell = false
vim.o.splitkeep = "screen"
vim.o.splitright = true
vim.o.sw = 4
vim.o.tabstop = 8
vim.o.ts = 4
vim.o.undofile = true
vim.o.wildmenu = true
vim.o.wrap = true
vim.opt.list = false
vim.opt.listchars = { eol="", trail = "▓", extends = ''}
vim.opt.fillchars = ""
vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')

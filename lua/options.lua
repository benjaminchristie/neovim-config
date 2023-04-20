--- set options --- 
vim.o.cursorline = true
vim.o.conceallevel = 0
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ch = 1
vim.cmd([[syntax on]])
vim.cmd([[hi SpellBad guibg=#ff2929 ctermbg=224]])
vim.o.spell = false
vim.o.showcmd = true
vim.o.relativenumber = true
vim.o.number = true
vim.o.foldenable = false
vim.o.backup = false
vim.o.signcolumn = "yes:1"
vim.o.undofile = true
vim.o.ts = 4
vim.o.sw = 4
vim.o.clipboard = "unnamedplus"
vim.o.splitright = true
vim.o.path = vim.o.path .. "**"
vim.o.wrap = true
vim.o.wildmenu = true
vim.o.sol = false
vim.o.foldmethod = "marker"
vim.o.foldmarker = "{{{,}}}"
vim.o.tabstop = 8
vim.o.softtabstop = 8
vim.o.shiftwidth = 4
vim.o.expandtab = false
vim.o.ls = 0
vim.o.autoindent = true
vim.o.mouse = "nv"

-- vim.opt.listchars = { eol="", tab = '' }
-- vim.opt.list = true

vim.g.undotree_WindowLayout = 2
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_ShortIndicators = 1

vim.g.syntastic_auto_jump = 1
vim.g.term_buf = 0
vim.g.term_win = 0
vim.g.loaded_gzip = 0
vim.g.loaded_tar = 0
vim.g.loaded_tarPlugin = 0
vim.g.loaded_zipPlugin = 0
vim.g.loaded_2html_plugin = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_spec = 1 -- vim.g.tex_conceal = "admgs"

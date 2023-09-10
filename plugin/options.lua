vim.api.nvim_set_var("line_number_interval#custom_interval", { 1, 2, 3, 4, 5 })
vim.api.nvim_set_var("line_number_interval#use_custom", 1)
vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', {})
vim.g.indent_blankline_char_list_blankline = { '|', '|', '|', '|', '|', "", "", "", "", "" }
vim.cmd("set shm+=I")
vim.g.plug_threads = 64
vim.g.plug_window = [[vertical topleft new]]
vim.g.dispatch_no_maps = 1
vim.g.editorconfig_trim_trailing_whitespace = true
vim.g.editorconfig_indent_style = "space"
vim.g.loaded_2html_plugin = 0
vim.g.syntastic_auto_jump = 1
vim.g.term_buf = 0
vim.g.term_win = 0
vim.g.tokyonight_italic_functions = true
vim.o.autoindent = true
vim.o.autoread = true
vim.o.backup = false
vim.o.ch = 1
vim.o.clipboard = "unnamedplus"
vim.o.cmdheight = 1
vim.o.conceallevel = 0
vim.o.cursorline = true
vim.o.dictionary = vim.fn.stdpath("config").. "/bin/dictionary/my.dict"
vim.o.expandtab = true
vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldenable = true
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.matchpairs = "(:),{:},[:],<:>"
vim.o.mouse = "inv"
vim.o.number = true
vim.o.path = vim.o.path .. "**"
vim.o.relativenumber = true
vim.o.shiftwidth = 4
vim.o.showcmd = true
vim.o.signcolumn = "yes:1"
vim.o.smartcase = true
vim.o.so = 0
vim.o.softtabstop = 8
vim.o.sol = false
vim.o.spell = false
vim.o.splitkeep = "screen"
vim.o.splitright = true
vim.o.sw = 4
vim.o.syntax = "on"
vim.o.tabstop = 8
vim.o.termguicolors = true
vim.o.ts = 4
vim.o.undofile = true
vim.o.wildmenu = true
vim.o.wrap = false
vim.opt.fillchars = ""
vim.opt.list = false
vim.opt.listchars = { eol = "↵", trail = "▓", extends = '' }

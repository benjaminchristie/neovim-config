vim.o.termguicolors = true
require("tokyonight").setup({
    transparent=true,
    style="moon",
    styles = {
	sidebars="transparent",
	floats = "transparent",
    },
    sidebars = {"feline"},
    dim_inactive = true,
})
vim.g.tokyonight_italic_functions = true
vim.g.tokyodark_transparent_background = true
vim.g.tokyodark_enable_italic_comment = true
vim.g.tokyodark_enable_italic = true
vim.g.tokyodark_color_gamma = "1.0"
vim.cmd("color tokyonight-moon")
vim.g.line_number_interval_enable_at_startup = 1
vim.cmd('let g:line_number_interval#use_custom = 1')
vim.cmd('let g:line_number_interval#custom_interval = [1,2,3,4,5]')
local colors = require("tokyonight.colors").setup()
vim.api.nvim_set_hl(0, 'SpellBad',     {bg="#ff2929"})
vim.api.nvim_set_hl(0, "CursorLine",   {bg = colors.bg_float})
vim.api.nvim_set_hl(0, "CursorLineNr", {fg = colors.orange})
vim.api.nvim_set_hl(0, "LineNr",       {fg = colors.fg_dark})
vim.api.nvim_set_hl(0, "Comment",      {fg = colors.dark5})
vim.api.nvim_set_hl(0, "Folded",       {bg = colors.black})
vim.api.nvim_set_hl(0, "Tabline", {
    fg = colors.orange,
    bg = colors.bg_float,
})
vim.api.nvim_set_hl(0, "TablineSel", {
    fg = colors.orange,
    bg = colors.bg_highlight,
    bold = true,
})
vim.api.nvim_set_hl(0, "WinBar", {
    fg = colors.orange,
    bg = colors.bg_float,
    bold = true,
})
vim.api.nvim_set_hl(0, "WinBarNC", {
    fg = colors.fg_float,
    bg = colors.bg_float,
})
vim.api.nvim_set_hl(0, "StatusLine", {
    fg = colors.orange,
    bg = colors.bg_float,
})
vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", {fg = colors.blue})
vim.api.nvim_set_hl(0, "DimLineNr",                  {fg = colors.fg_dark})
vim.api.nvim_set_hl(0, 'HighlightedLineNr1',         {fg='#7ac2ca'})
vim.api.nvim_set_hl(0, 'HighlightedLineNr2',         {fg='#7cb4c6'})
vim.api.nvim_set_hl(0, 'HighlightedLineNr3',         {fg='#7da8c3'})
vim.api.nvim_set_hl(0, 'HighlightedLineNr4',         {fg='#7f9bdf'})
vim.api.nvim_set_hl(0, 'HighlightedLineNr5', {fg='#8093bc'})

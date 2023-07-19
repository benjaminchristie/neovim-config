vim.o.termguicolors = true
require("tokyonight").setup({
    transparent=true,
    -- style="night",
    style="moon",
    styles = {
	sidebars="transparent",
	floats = "transparent",
    },
    sidebars = {"feline"},
    dim_inactive = true,
})
vim.g.tokyonight_italic_functions = true
require('onedark').setup  {
    -- Main options --
    style = 'cool', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = false,  -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

    -- toggle theme style ---
    toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },

    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },
}
vim.g.tokyodark_transparent_background = true
vim.g.tokyodark_enable_italic_comment = true
vim.g.tokyodark_enable_italic = true
vim.g.tokyodark_color_gamma = "1.0"
-- vim.cmd("colorscheme tokyodark")
-- require('onedark').load()
vim.cmd("color tokyonight-moon")
local colors = require("tokyonight.colors").setup()
vim.cmd("highlight CursorLine guibg="..colors.bg_float)
vim.cmd("highlight CursorLineNr guifg="..colors.orange)
vim.cmd("highlight LineNr guifg="..colors.fg_dark)
vim.cmd("highlight Comment guifg="..colors.dark5)
vim.cmd("highlight Tabline guifg="..colors.dark5)
vim.cmd("highlight TablineSel guibg="..colors.teal)
vim.cmd("highlight WinBar guifg=" .. colors.orange .. " gui=bold guibg=".. colors.bg_float)
vim.cmd("highlight WinBarNC guifg=" .. colors.fg_float .. " guibg=".. colors.bg_float)
vim.cmd("highlight StatusLine guibg=".. colors.bg_float)
vim.cmd("highlight StatusLineNC guibg=".. colors.bg_float)
vim.cmd('let g:line_number_interval_enable_at_startup = 1')
vim.cmd('let g:line_number_interval#use_custom = 1')
vim.cmd('let g:line_number_interval#custom_interval = [1,2,3,4,5]')
vim.cmd('highlight DimLineNr          guifg='..colors.fg_dark)
vim.cmd('highlight HighlightedLineNr1 guifg=#7ac2ca')
vim.cmd('highlight HighlightedLineNr2 guifg=#7cb4c6')
vim.cmd('highlight HighlightedLineNr3 guifg=#7da8c3')
vim.cmd('highlight HighlightedLineNr4 guifg=#7f9bdf')
vim.cmd('highlight HighlightedLineNr5 guifg=#8093bc')

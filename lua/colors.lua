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

-- [<Color #ff966c>, <Color #fdab6c>, <Color #fabf6c>, <Color #f8d26d>, <Color #f6e56d>, <Color #f0f36e>, <Color #daf16e>, <Color #c5ee6f>, <Color #b1eb6f>, <Color #9ee970>, <Color #8ce671>, <Color #7ce372>, <Color #73e079>, <Color #74dd89>, <Color #75da99>, <Color #76d7a6>, <Color #77d4b3>, <Color #78d0bf>, <Color #79cdc9>, <Color #7ac2ca>, <Color #7cb4c6>, <Color #7da8c3>, <Color #7f9dbf>, <Color #8093bc>, <Color #828bb8>]

-- [<Color #a9b1d6>, <Color #9fcddc>, <Color #94e2c8>, <Color #89e892>, <Color #b3ef7d>, <Color #f7f071>, <Color #ff9e64>]
-- [<Color #ff9e64>, <Color #fea966>, <Color #fdb467>, <Color #fcbf69>, <Color #fbc96a>, <Color #fad36c>, <Color #f9dd6d>, <Color #f8e66f>, <Color #f7ef71>, <Color #f5f672>, <Color #ebf574>, <Color #e1f475>, <Color #d8f377>, <Color #cff278>, <Color #c6f17a>, <Color #bef17b>, <Color #b6f07d>, <Color #aeef7e>, <Color #a7ee7f>, <Color #a0ed81>, <Color #99ec82>, <Color #93eb84>, <Color #8dea85>, <Color #87ea87>, <Color #88e98e>, <Color #89e896>, <Color #8be79e>, <Color #8ce6a5>, <Color #8ee5ac>, <Color #8fe5b3>, <Color #90e4b9>, <Color #92e3bf>, <Color #93e2c5>, <Color #94e1ca>, <Color #96e1cf>, <Color #97e0d4>, <Color #98dfd9>, <Color #9adedd>, <Color #9bdade>, <Color #9cd5dd>, <Color #9ed0dc>, <Color #9fccdb>, <Color #a0c7db>, <Color #a2c3da>, <Color #a3c0d9>, <Color #a4bcd9>, <Color #a5b9d8>, <Color #a7b6d7>, <Color #a8b3d7>, <Color #a9b1d6>

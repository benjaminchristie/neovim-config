require("tokyonight").setup({
    transparent = true,
    style = "moon",
    styles = {
        sidebars = "transparent",
        floats = "transparent",
    },
    sidebars = { "feline" },
    dim_inactive = true,
})
vim.cmd("color tokyonight-moon")
local colors = require("tokyonight.colors").setup()
vim.api.nvim_set_hl(0, 'SpellBad', { bg = "#ff2929" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.bg_float })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.orange })
vim.api.nvim_set_hl(0, "LineNr", { fg = colors.fg_dark })
vim.api.nvim_set_hl(0, "Comment", { fg = colors.dark5 })
vim.api.nvim_set_hl(0, "Folded", { bg = colors.black })
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = colors.fg_dark })
vim.api.nvim_set_hl(0, "LspInlayHint", {
    fg = "#5B5F76",
    bg = colors.bg_float,
    italic = true,
})
vim.api.nvim_set_hl(0, "GhostText", {
    fg = "#5B5F76",
    bg = colors.bg_float,
})
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
vim.api.nvim_set_hl(0, "StatusLineNC", {
    fg = colors.fg_dark,
    bg = colors.bg_float,
})
vim.api.nvim_set_hl(0, 'MatchParen', {
    fg = colors.orange,
    bold = true,
})
vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', {
    fg = colors.dark5,
})
vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = colors.blue })
vim.api.nvim_set_hl(0, "DimLineNr", { fg = colors.fg_dark })
vim.api.nvim_set_hl(0, 'HighlightedLineNr1', { fg = '#7ac2ca' })
vim.api.nvim_set_hl(0, 'HighlightedLineNr2', { fg = '#7cb4c6' })
vim.api.nvim_set_hl(0, 'HighlightedLineNr3', { fg = '#7da8c3' })
vim.api.nvim_set_hl(0, 'HighlightedLineNr4', { fg = '#7f9bdf' })
vim.api.nvim_set_hl(0, 'HighlightedLineNr5', { fg = '#8093bc' })

vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = colors.red })
vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { fg = colors.purple })
vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = colors.blue })
vim.api.nvim_set_hl(0, 'DapStopped', { fg = colors.orange })
vim.fn.sign_define('DapBreakpoint', { text = 'B', texthl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text = 'C', texthl = 'DapBreakpointCondition' })
vim.fn.sign_define('DapLogPoint', { text = 'L', texthl = 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text = '→', texthl = 'DapStopped' })

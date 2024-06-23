return {
    'folke/tokyonight.nvim',
    lazy = true,
    enabled = true,
    priority = 1000,
    config = function()
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
        local cursor_line_nr_colors = { '#7ac2ca', '#7cb4c6', '#7da8c3', '#7f9bdf', '#8093bc' }
        local conceal_colors = { colors.red, '#d2cb8a', '#e1af86', '#f09283', colors.green }
        vim.api.nvim_set_hl(0, 'SpellBad', { bg = "#ff2929" })
        vim.api.nvim_set_hl(0, 'ColorColumn',{ link = "DiffText" })
        vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.bg_float })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.orange })
        vim.api.nvim_set_hl(0, "LineNr", { fg = colors.fg_dark })
        vim.api.nvim_set_hl(0, "Comment", { fg = colors.dark5 })
        vim.api.nvim_set_hl(0, "Folded", { bg = colors.black })
        vim.api.nvim_set_hl(0, 'WinSeparator', { fg = colors.fg_dark })
        vim.api.nvim_set_hl(0, 'LocalHighlight', { bg = "#27293E" })
        -- vim.api.nvim_set_hl(0, 'LocalHighlight', { underline = true })
        vim.api.nvim_set_hl(0, 'LspCodeLens', { italic = true })
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
            bold = false,
        })
        vim.api.nvim_set_hl(0, "WinBarLSP", {
            fg = colors.fg_dark,
            bg = colors.bg_float,
        })
        vim.api.nvim_set_hl(0, "WinBarHarpoon", {
            fg = colors.purple,
            bg = colors.bg_float,
        })
        vim.api.nvim_set_hl(0, "WinBarGit", {
            fg = colors.blue,
            bg = colors.bg_float,
            bold = false
        })
        vim.api.nvim_set_hl(0, "WinBarGitAdded", {
            fg = colors.green,
            bg = colors.bg_float,
            bold = false,
        })
        vim.api.nvim_set_hl(0, "WinBarGitSubbed", {
            fg = colors.red,
            bg = colors.bg_float,
            bold = false,
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
        vim.api.nvim_set_hl(0, 'LightBulbSign', {
            fg = colors.yellow,
        })
        vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = colors.blue })
        vim.api.nvim_set_hl(0, "DimLineNr", { fg = colors.fg_dark })
        vim.api.nvim_set_hl(0, 'HighlightedLineNr1', { fg = cursor_line_nr_colors[1] })
        vim.api.nvim_set_hl(0, 'HighlightedLineNr2', { fg = cursor_line_nr_colors[2] })
        vim.api.nvim_set_hl(0, 'HighlightedLineNr3', { fg = cursor_line_nr_colors[3] })
        vim.api.nvim_set_hl(0, 'HighlightedLineNr4', { fg = cursor_line_nr_colors[4] })
        vim.api.nvim_set_hl(0, 'HighlightedLineNr5', { fg = cursor_line_nr_colors[5] })

        vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = colors.red })
        vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { fg = colors.purple })
        vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = colors.blue })
        vim.api.nvim_set_hl(0, 'DapStopped', { fg = colors.orange })
        vim.fn.sign_define('DapBreakpoint', { text = 'B', texthl = 'DapBreakpoint' })
        vim.fn.sign_define('DapBreakpointCondition', { text = 'C', texthl = 'DapBreakpointCondition' })
        vim.fn.sign_define('DapLogPoint', { text = 'L', texthl = 'DapLogPoint' })
        vim.fn.sign_define('DapStopped', { text = '→', texthl = 'DapStopped' })
        for i = 1, 5, 1 do
            vim.api.nvim_set_hl(0, string.format('@text.title.%d.markdown', i), {
                fg = conceal_colors[i],
                bg = colors.bg_highlight,
                bold = true,
            })
        end
        vim.api.nvim_set_hl(0, "@punctuation.special.markdown", {
            fg = colors.blue,
            bold = true,
        })
        vim.api.nvim_set_hl(0, "@marker_conceal.markdown", {
            fg = colors.blue,
            bold = true,
        })
        vim.api.nvim_set_hl(0, "@heading_conceal.markdown", {
            fg = colors.orange,
            bg = colors.bg_highlight,
            bold = true,
        })
        vim.api.nvim_set_hl(0, 'FidgetTitle', { bg = colors.bg_float })
        vim.api.nvim_set_hl(0, 'FidgetTask', { bg = colors.bg_float })
    end
}

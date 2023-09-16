M = {
    require("color-plugins/tokyonight"),
    require("color-plugins/zenbones"),
    require("color-plugins/indent-blankline"),
    require("color-plugins/linenumberinterval"),
    require("color-plugins/highlight-undo"),
    require("color-plugins/local-highlight"),
    require("color-plugins/smart-column"),
	{
		'projekt0n/github-nvim-theme',
		config = function()
			vim.cmd('colorscheme github_dark_high_contrast')
			vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { link = "Comment"})
			vim.api.nvim_set_hl(0, 'LocalHighlight', { link = "NormalFloat"})
			vim.api.nvim_set_hl(0, 'MiniStarterItemPrefix', { link = "WarningMsg"})
			vim.api.nvim_set_hl(0, "GhostText", {
				link = "Comment"
			})
			vim.api.nvim_set_hl(0, "WinBar", {
				fg = "LightMagenta"
			})
			vim.api.nvim_set_hl(0, "WinBarLSP", {
				fg = "LightCyan",
				bg = "NONE",
				italic = false
			})
			vim.api.nvim_set_hl(0, "WinBarGit", {
				link = "Normal"
			})
			vim.api.nvim_set_hl(0, "StatusLine", {
				link = "FloatFooter"
			})
			vim.api.nvim_set_hl(0, "StatusLineNC", {
				link = "Normal"
			})
			vim.api.nvim_set_hl(0, 'LocalHighlight', {
				link = "" -- haven't found a good highlight for this
			})
			vim.api.nvim_set_hl(0, "WinBarGit", {
				fg = "LightCyan",
				bg = "NONE"
			})
			vim.api.nvim_set_hl(0, "WinBarGitAdded", {
				fg = "green",
				bg = "NONE"
			})
			vim.api.nvim_set_hl(0, "WinBarGitSubbed", {
				fg = "red",
				bg = "NONE"
			})
		end,
		enabled = true,
		lazy = false,
		priority = 1000,
	},
	{
		'navarasu/onedark.nvim',
		config = function()
			require("onedark").setup({
				style = "darker"
			})
			require("onedark").load()
			vim.api.nvim_set_hl(0, "StatusLine", {
				link = "FloatFooter"
			})
			vim.api.nvim_set_hl(0, "StatusLineNC", {
				link = "Normal"
			})
			vim.api.nvim_set_hl(0, 'LocalHighlight', { link = "Normal"})
			vim.api.nvim_set_hl(0, "WinBarGitAdded", {
				link = "DiffAdd"
			})
			vim.api.nvim_set_hl(0, "WinBarGitSubbed", {
				link = "DiffDelete"
			})
			vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { link = "CursorLineNR"})
		end,
	},
	{
		't184256/vim-boring',
		config = function()
			vim.cmd([[colorscheme boring]])
			vim.api.nvim_set_hl(0, "StatusLine", {
				link = "FloatFooter"
			})
			vim.api.nvim_set_hl(0, "StatusLineNC", {
				link = "Normal"
			})
			vim.api.nvim_set_hl(0, "CursorLine", {
				link = "CursorIM"
			})
			vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { link = "CursorLineNR"})
		end,
		enabled = true,
		lazy = true,
	}
}
return M

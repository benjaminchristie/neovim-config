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
				link = "Normal"
			})
			vim.api.nvim_set_hl(0, "WinBarLSP", {
				link = "Conceal",
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
		end,
		enabled = true,
		lazy = false,
		priority = 1000,
	},
	{
		'navarasu/onedark.nvim',
		opts = {
			style = 'darker'
		},
		config = function()
			vim.api.nvim_set_hl(0, "StatusLine", {
				link = "FloatFooter"
			})
			vim.api.nvim_set_hl(0, "StatusLineNC", {
				link = "Normal"
			})
		end
	},
}
return M

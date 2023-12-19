return {
	{
		'projekt0n/github-nvim-theme',
		config = function()
			vim.cmd('colorscheme github_dark_high_contrast')
			require('github-theme').setup({
				options = {
					dim_inactive = false,
				}
			})
			vim.api.nvim_set_hl(0, "Normal", { bg = "black" })
			vim.api.nvim_set_hl(0, "NormalNC", { bg = "black" })
			vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { link = "Comment" })
			vim.api.nvim_set_hl(0, 'LocalHighlight', { link = "NormalFloat" })
			vim.api.nvim_set_hl(0, 'MiniStarterItemPrefix', { link = "WarningMsg" })
			vim.api.nvim_set_hl(0, "GhostText", {
				link = "Comment"
			})
			vim.api.nvim_set_hl(0, "ColorColumn", {
				bg = "orange",
				blend = 5
			})
			vim.api.nvim_set_hl(0, "WinBar", {
				link = "FloatFooter"
			})
			vim.api.nvim_set_hl(0, "WinBarLSP", {
				link = "FloatFooter"
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
	},
	{
		'navarasu/onedark.nvim',
		config = function()
			require("onedark").setup({
				style = "darker"
			})
			require("onedark").load()
			vim.api.nvim_set_hl(0, 'WinSeparator', { link = "Comment", italic = false })
			vim.api.nvim_set_hl(0, "StatusLine", {
				link = "FloatFooter"
			})
			vim.api.nvim_set_hl(0, "StatusLineNC", {
				link = "Normal"
			})
			vim.api.nvim_set_hl(0, 'LocalHighlight', { link = "Normal" })
			vim.api.nvim_set_hl(0, "WinBarGitAdded", {
				fg = "green",
				bg = "NONE",
			})
			vim.api.nvim_set_hl(0, "WinBarGitSubbed", {
				fg = "red",
				bg = "NONE",
			})
			vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { link = "CursorLineNR" })
			vim.api.nvim_set_hl(0, 'LocalHighlight', {
				link = "" -- haven't found a good highlight for this
			})
			vim.api.nvim_set_hl(0, "GhostText", {
				link = "Comment"
			})
			vim.api.nvim_set_hl(0, "WinBar", {
				link = "FloatFooter"
			})
			vim.api.nvim_set_hl(0, "WinBarNC", {
				link = "FloatFooterNC"
			})
			vim.api.nvim_set_hl(0, "WinBarGit", {
				link = "Normal"
			})

			vim.api.nvim_set_hl(0, '@text.title.1.markdown', {
				fg = "red",
				bg = "NONE",
				bold = true,
			})
			vim.api.nvim_set_hl(0, '@text.title.2.markdown', {
				fg = "orange",
				bg = "NONE",
				bold = true,
			})
			vim.api.nvim_set_hl(0, '@text.title.3.markdown', {
				fg = "green",
				bg = "NONE",
				bold = true,
			})
			vim.api.nvim_set_hl(0, '@text.title.4.markdown', {
				fg = "cyan",
				bg = "NONE",
				bold = true,
			})
			vim.api.nvim_set_hl(0, '@text.title.5.markdown', {
				fg = "blue",
				bg = "NONE",
				bold = true,
			})
			vim.api.nvim_set_hl(0, "@punctuation.special.markdown", {
				fg = "orange",
				bold = true,
			})
			vim.api.nvim_set_hl(0, "@marker_conceal.markdown", {
				fg = "orange",
				bold = true,
			})
			vim.api.nvim_set_hl(0, "@heading_conceal.markdown", {
				fg = "orange",
				bg = "NONE",
				bold = true,
			})
		end,
		enabled = true,
		lazy = false,
		priority = 1000,
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
			vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { link = "CursorLineNR" })
		end,
		enabled = true,
		lazy = true,
	}
}

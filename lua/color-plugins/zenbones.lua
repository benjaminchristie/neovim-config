return {
	'mcchrish/zenbones.nvim',
    dependencies = {
		{"rktjmp/lush.nvim"}
	},
	enabled = true,
	lazy = false,
	priority = 1000,
	config = function ()
		vim.o.termguicolors = true
		vim.o.background = "dark"
		vim.cmd([[colorscheme tokyobones]])
        vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { link = "Footer"})
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
	end
}

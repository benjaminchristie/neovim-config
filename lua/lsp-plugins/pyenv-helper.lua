return {
	'AckslD/swenv.nvim',
	dependencies = {
		'ibhagwan/fzf-lua', -- for ui.select
		'neovim/nvim-lspconfig',
	},
	opts = {
		venvs_path = vim.fn.expand('~/.pyenv/versions'),
		post_set_venv = function()
            vim.cmd("LspRestart")
        end
	},
	ft = "python",
    cmd = "PyenvActivate",
}

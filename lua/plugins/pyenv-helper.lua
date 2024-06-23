return {
    'AckslD/swenv.nvim',
    dependencies = {
        'neovim/nvim-lspconfig',
    },
    config = function()
        local opts = {
            venvs_path = vim.fn.expand('~/.pyenv/versions'),
            post_set_venv = function()
                vim.cmd("LspRestart")
            end
        }
        require("swenv").setup(opts)
        vim.api.nvim_create_user_command("PyenvActivate",
            require("functions").pick_pyenv,
            {
                desc = "pyenv picker"
            }
        )
    end,
    ft = "python",
}

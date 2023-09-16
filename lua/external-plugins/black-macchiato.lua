return {
    'wbolster/black-macchiato',
    enabled = function()
        return vim.fn.executable("pip") == 1
    end,
    build = vim.fn.stdpath("config") .. "/bin/pip-script.sh black-macchiato",
}

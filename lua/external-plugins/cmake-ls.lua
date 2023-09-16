return {
    'regen100/cmake-language-server',
    enabled = function()
        return vim.fn.executable("pip") == 1
    end,
    build = vim.fn.stdpath("config") .. "/bin/pip-script.sh testresources cmake-language-server",
}

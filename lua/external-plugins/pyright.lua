return {
    'RobertCraigie/pyright-python',
    enabled = function()
        return vim.fn.executable("pip")
    end,
    build = vim.fn.stdpath("config") .. "/bin/pip-script.sh testresources pyright",
}

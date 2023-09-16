return {
    'artempyanykh/marksman',
    build = 'make install',
    enabled = function()
        return vim.fn.executable("dotnet") == 1
    end,
    pin = true,
}

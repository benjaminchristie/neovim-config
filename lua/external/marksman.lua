return {
    'artempyanykh/marksman',
    build = 'make install',
    enabled = function()
        return vim.fn.executable("dotnet")
    end,
    pin = true,
}

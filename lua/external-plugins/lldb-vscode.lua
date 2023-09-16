return {
    "tomblind/local-lua-debugger-vscode",
    enabled = function()
        return vim.fn.executable("npm") == 1
    end,
    pin = false,
    build = "npm install && npm run build",
}

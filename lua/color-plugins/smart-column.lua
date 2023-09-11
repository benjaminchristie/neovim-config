return {
    "m4xshen/smartcolumn.nvim",
    opts = {
        colorcolumn = "120",
        scope = "line",
        disabled_filetypes = {
            "lazy",
            "terminal",
            "help",
            "starter",
        }
    },
    event = {"BufReadPre", "BufNewFile"},
}

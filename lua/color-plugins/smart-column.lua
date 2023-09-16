return {
    "benjaminchristie/smartcolumn.nvim",
    opts = {
        colorcolumn = "120",
        scope = "line",
        disabled_filetypes = {
            "lazy",
            "terminal",
            "help",
            "starter",
            "DiffviewFileHistory",
        }
    },
    event = {"BufReadPre", "BufNewFile"},
    dev = false
}

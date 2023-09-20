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
            "tex",
            "DiffviewFileHistory",
        }
    },
    event = {"BufReadPre", "BufNewFile"},
    dev = false
}

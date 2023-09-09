require("nvim-lightbulb").setup({
    hide_in_unfocused_buffer = false,
    sign = {
        enabled = true,
        text = "💡",
        hl = "LightBulbSign",
    },
    autocmd = {
        enabled = true,
        updatetime = 10
    },
    ignore = {
        clients = {
            "lua_ls"
        }
    }
})

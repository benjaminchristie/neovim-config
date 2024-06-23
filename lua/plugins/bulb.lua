return {
    'kosayoda/nvim-lightbulb',
    opts = {
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
            ft = { 
                "lua",
                "markdown",
            }
        }
    },
	enabled = false
}

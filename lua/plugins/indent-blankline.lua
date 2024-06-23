return {
    'lukas-reineke/indent-blankline.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("ibl").setup({
            scope = {
                enabled = true,
                show_start = false,
                show_end = false,
                highlight = "IndentBlanklineContextChar"
            },
            whitespace = {
                remove_blankline_trail = true
            },
            indent = {
                char = '│',
				smart_indent_cap = true,
            }
        })
    end,
}

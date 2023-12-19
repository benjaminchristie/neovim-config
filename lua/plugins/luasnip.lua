return {
    'L3MON4D3/LuaSnip',
    event = "VeryLazy",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    opts = {
        history = true,
        delete_check_events = "TextChanged",
    },
    keys = {
        {
            "<tab>",
            function()
                return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
            end,
            expr = true,
            silent = true,
            mode = "i",
        },
        {
            "<s-tab>",
            function()
                return require("luasnip").jumpable(-1) and "<Plug>luasnip-jump-prev" or "<s-tab>"
            end,
            expr = true,
            silent = true,
            mode = "i",
        },
        { "<tab>",   function() require("luasnip").jump(1) end,  mode = { "s" } },
        { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "s" } },
    },
}

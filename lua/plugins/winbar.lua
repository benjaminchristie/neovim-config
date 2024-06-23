return {
        dependencies = {
            'lewis6991/gitsigns.nvim',
            'nvim-treesitter/nvim-treesitter',
            -- 'ThePrimeagen/harpoon',
        },
        config = function()
            require("statuswinbar").setup()
        end,
        dir = "statuswinbar",
        name = "statuswinbar",
        event = { "BufReadPre", "BufNewFile" },
}

M = {
    -- personal plugins:
    require("accessory-plugins/perfanno"),
    require("accessory-plugins/qfedit"),
    require("accessory-plugins/csgithub"),
    require("accessory-plugins/remember"),
    require("accessory-plugins/starter"),
    require("accessory-plugins/harpoon"),
    require("accessory-plugins/surround"),
    require("accessory-plugins/godbolt"),
    require("accessory-plugins/colorizer"),
    require("accessory-plugins/eunuch"),
    require("accessory-plugins/repeat"),
    require("accessory-plugins/sniprun"),
    require("accessory-plugins/commentary"),
    require("accessory-plugins/startuptime"),
    require("accessory-plugins/dispatch"),
    require("accessory-plugins/numb"),
    {
        dependencies = {
            'lewis6991/gitsigns.nvim',
            'nvim-treesitter/nvim-treesitter',
            'ThePrimeagen/harpoon',
        },
        config = function()
            require("statuswinbar").setup()
        end,
        dir = "statuswinbar",
        name = "statuswinbar",
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        name = "custom-keymaps",
        config = function()
            require("custom-keymaps")
        end,
        dir = "custom-keymaps",
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        name = "custom-functions",
        config = function()
            require("custom-functions")
        end,
        dir = "custom-functions",
        event = { "BufReadPre", "BufNewFile" },
    }
}
return M

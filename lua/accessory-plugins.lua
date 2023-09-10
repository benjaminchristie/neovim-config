local modules = {
    -- personal plugins:
    require("accessory/perfanno"),
    require("accessory/qfedit"),
    require("accessory/csgithub"),
    require("accessory/remember"),
    require("accessory/localhighlight"),
    require("accessory/starter"),
    require("accessory/harpoon"),
    require("accessory/surround"),
    require("accessory/godbolt"),
    require("accessory/colorizer"),
    require("accessory/eunuch"),
    require("accessory/repeat"),
    require("accessory/sniprun"),
    require("accessory/commentary"),
    require("accessory/startuptime"),
    require("accessory/dispatch"),
    require("accessory/numb"),
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
        name = "make-flow",
        dir = "make-flow",
        ft = "markdown",
    },
    {
        name = "custom-functions",
        config = function()
            require("custom-functions")
        end,
        dir = "custom-functions",
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        name = "custom-keymaps",
        config = function()
            require("custom-keymaps")
        end,
        dir = "custom-keymaps",
        event = { "BufReadPre", "BufNewFile" },

    }
}
return modules

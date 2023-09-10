return {
    'ThePrimeagen/harpoon',
    event = "VeryLazy",
    keys = {
        { "<A-0>", function() return require("harpoon.ui").nav_file(0) end },
        { "<A-1>", function() return require("harpoon.ui").nav_file(1) end },
        { "<A-2>", function() return require("harpoon.ui").nav_file(2) end },
        { "<A-3>", function() return require("harpoon.ui").nav_file(3) end },
        { "<A-4>", function() return require("harpoon.ui").nav_file(4) end },
        { "<A-5>", function() return require("harpoon.ui").nav_file(5) end },
        { "<A-6>", function() return require("harpoon.ui").nav_file(6) end },
        { "<A-7>", function() return require("harpoon.ui").nav_file(7) end },
        { "<A-8>", function() return require("harpoon.ui").nav_file(8) end },
        { "<A-9>", function() return require("harpoon.ui").nav_file(9) end },
        { "<A-h>", function() return require("harpoon.ui").toggle_quick_menu() end },
        { "<A-m>", function() return require("harpoon.mark").add_file() end },
        { "<A-k>", function() return require("harpoon.ui").nav_prev() end },
        { "<A-j>", function() return require("harpoon.ui").nav_next() end },
    }
}

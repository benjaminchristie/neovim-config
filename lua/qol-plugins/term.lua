return {
    'akinsho/toggleterm.nvim',
    config = function()
        require("toggleterm").setup {
            size = 40,
            open_mapping = [[<A-t>]],
            direction = 'float',
            shade_terminals = false,
            persist_size = false,
        }

        local Terminal = require('toggleterm.terminal').Terminal
        local pyterm = Terminal:new({ cmd = "/usr/bin/python", hidden = true })
        vim.keymap.set('n', [[<A-y>]], function() pyterm:toggle() end)
        vim.keymap.set('t', [[<A-y>]], function() pyterm:toggle() end)
    end,
    keys = {
        { "<A-t>" },
        { "<A-y>" },
    }
}

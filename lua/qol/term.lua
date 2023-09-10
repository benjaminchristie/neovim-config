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

        vim.api.nvim_create_augroup("TerminalKeymaps", { clear = true })
        vim.api.nvim_create_autocmd({ "TermOpen" }, {
            pattern = "term://*",
            callback = function()
                vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], { noremap = true })
                vim.opt_local.number = false
                vim.opt_local.relativenumber = false
            end
        })

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

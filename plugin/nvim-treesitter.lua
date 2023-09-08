require('nvim-dap-repl-highlights').setup()
require("nvim-treesitter.configs").setup({
    auto_install = true,
    highlight = {
        enable = true,
        disable = { "tex", "latex" },
    },
    ensure_installed = { 'dap_repl' },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn',
            scope_incremental = '<CR>',
            node_incremental = '<TAB>',
            node_decremental = '<S-TAB>',
        }
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ['al'] = '@loop.outer',
                ['il'] = '@loop.inner',
            }
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']f'] = '@function.outer',
                [']if'] = '@function.inner',
                [')'] = '@parameter.inner',
                [']c'] = '@call.outer',
                [']ic'] = '@call.inner',
            },
            goto_next_end = {
                [']F'] = '@function.outer',
                [']iF'] = '@function.inner',
                ['g)'] = '@parameter.inner',
                [']C'] = '@call.outer',
                [']iC'] = '@call.inner',
            },
            goto_previous_start = {
                ['[f'] = '@function.outer',
                ['[if'] = '@function.inner',
                ['('] = '@parameter.inner',
                ['[c'] = '@call.outer',
                ['[ic'] = '@call.inner',
            },
            goto_previous_end = {
                ['[F'] = '@function.outer',
                ['[iF'] = '@function.inner',
                ['g('] = '@parameter.inner',
                ['[C'] = '@call.outer',
                ['[iC'] = '@call.inner',
            },
        }
    }
})
local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
local gs = require("gitsigns")

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- make sure forward function comes first
local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
-- Or, use `make_repeatable_move` or `set_last_move` functions for more control. See the code for instructions.

vim.keymap.set({ "n", "x", "o" }, "]g", next_hunk_repeat)
vim.keymap.set({ "n", "x", "o" }, "[g", prev_hunk_repeat)
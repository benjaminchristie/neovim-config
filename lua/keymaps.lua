local utils = require('utils')
local funcs = require("functions")
local keymap = utils.keymap

-- basically a keymap
vim.api.nvim_create_user_command("W", "w", { desc = "alias to :w" })
vim.api.nvim_create_user_command("Q", "q", { desc = "alias to :q" })
vim.api.nvim_create_user_command("Wq", "wq", { desc = "alias to :wq" })
vim.api.nvim_create_user_command("WQ", "wq", { desc = "alias to :wq" })

keymap('n', '<Left>', 'gT')
keymap('n', '<Right>', 'gt')
keymap('i', '<Left>', '<Esc>gT')
keymap('i', '<Right>', '<Esc>gt')
keymap('n', '`1', ':5winc<<CR>')
keymap('n', '`4', ':5winc><CR>')
keymap('n', '`2', ':3winc+<CR>')
keymap('n', '`3', ':3winc-<CR>')
keymap('v', "J", ":m '>+1<CR>gv=gv")
keymap('v', "K", ":m '<-2<CR>gv=gv")
keymap('n', '<C-d>', '<C-d>zz')
keymap('n', '<C-u>', '<C-u>zz')
keymap('n', 'dl', ':diffget //3<CR>')
keymap('n', 'dh', ':diffget //2<CR>')
keymap('n', "<A-p>", ":cprev<CR>")
keymap('n', "<A-n>", ":cnext<CR>")

-- keymap('n', 'n', function() funcs.increment_search(funcs.timed_color_change) end, { noremap = true, silent = true, nowait = true })
-- keymap('n', 'N', function() funcs.decrement_search(funcs.timed_color_change) end, { noremap = true, silent = true, nowait = true })

keymap('n', '<C-_>', funcs.comment_line_preserve_cursor) -- this maps to <C-/>

keymap('n', '<A-c>', funcs.cd_to_cfile)

keymap('n', '\\s', funcs.find_and_replace_all_cword)

keymap('n', "<A-e>", funcs.on_demand_autogroup)

keymap("n", "<A-l>", funcs.lazy_load)

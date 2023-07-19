require("toggleterm").setup{
    size = 40,
    open_mapping = [[<A-t>]],
    direction = 'float',
    shade_terminals = false,
    persist_size = false,
}

function _G.set_terminal_keymaps()
    local opts = {noremap = true}
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
end
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
local Terminal = require('toggleterm.terminal').Terminal
local pyterm = Terminal:new({cmd = "python3", hidden = true})
function _PYTHON_TOGGLE()
    pyterm:toggle()
end
vim.keymap.set('n', [[<A-p>]], _PYTHON_TOGGLE)

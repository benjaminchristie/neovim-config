vim.loader.enable()

vim.o.hlsearch = true
vim.o.incsearch = true

vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '}', '}zz')
vim.keymap.set('n', '{', '{zz')
vim.keymap.set('n', '<Up>', '<C-b>')
vim.keymap.set('n', '<Down>', '<C-f>')
vim.keymap.set('n', '<Left>', 'gT')
vim.keymap.set('n', '<Right>', 'gt')
vim.keymap.set('n', '\\s', function ()
    local word = vim.fn.expand("<cword>")
    local line_num = vim.api.nvim_win_get_cursor(0)[1]
    local change_to = vim.fn.input("Change " .. word .. " to : ")
    vim.cmd(':%s/' .. word .. "/" .. change_to .. "/g")
    vim.cmd(":" .. line_num)
    end
)
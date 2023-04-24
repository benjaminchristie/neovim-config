vim.cmd([[
function! NvimGdbNoTKeymaps()
  tnoremap <silent> <buffer> <esc> <c-\><c-n>
endfunction

let g:nvimgdb_config_override = {
  \ 'key_next': 'n',
  \ 'key_step': 's',
  \ 'key_finish': 'f',
  \ 'key_continue': 'c',
  \ 'key_until': 'u',
  \ 'key_breakpoint': 'b',
  \ 'set_tkeymaps': "NvimGdbNoTKeymaps",
  \ }
  ]])


local function python_suite()
    vim.cmd(":GdbStartPDB python -m pdb %<CR>")
    vim.cmd(":GdbCreateWatch pp locals()<CR>:lua vim.opt_local.number = false<CR>:vim.opt_local.relativenumber = false<CR>")
end

vim.api.nvim_create_autocmd({"BufAdd"}, {
    pattern = {"*pp locals()*", "*pp globals()*", "*locals()*", "*globals()*"},
    callback = function ()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
    end
})
vim.keymap.set("n", "<A-b><A-b>", ":GdbStartPDB python -m pdb %<CR><C-\\><C-n>")
vim.keymap.set("n", "<A-b><A-q>", ":GdbDebugStop<CR>")
vim.keymap.set("n", "<A-b><A-l>", ":GdbCreateWatch pp locals()<CR>:lua vim.opt_local.number = false<CR>:lua vim.opt_local.relativenumber = false<CR>")


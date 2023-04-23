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

vim.keymap.set("n", "<A-b><A-b>", ":GdbStartPDB python -m pdb %<CR>")
vim.keymap.set("n", "<A-b><A-l>", ":GdbCreateWatch pp locals()<CR>")

vim.bo.matchpairs = "(:),{:},[:],<:>,=:;,"
vim.keymap.set('n', "<A-f>", function()
    vim.cmd("ClangFormat")
end)

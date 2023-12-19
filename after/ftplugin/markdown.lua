if not vim.o.readonly then
    vim.wo[0][0].spell = true
    vim.wo[0][0].wrap = true
    local make_flow = require("make-flow")
    require("utils").buf_keymap({ "n" }, "<C-l><C-p>", make_flow.pandocCompile)
end
vim.wo[0][0].conceallevel = 2

if not vim.o.readonly then
    vim.wo[0][0].conceallevel = 2
    vim.wo[0][0].spell = true
    vim.wo[0][0].wrap = true
    local make_flow = require("make-flow")
    vim.keymap.set({ "n" }, "<C-l><C-p>", make_flow.pandocCompile, {buffer = vim.fn.bufnr()})
end

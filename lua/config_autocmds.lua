--- menus
vim.cmd([[
aunmenu PopUp
vnoremenu PopUp.Cut                         "+x
vnoremenu PopUp.Copy                        "+y
vnoremenu PopUp.Paste                       "+P
nnoremenu PopUp.Go\ To\ Definition          <Cmd>lua vim.fn.feedkeys("gd")<CR>
nnoremenu PopUp.Go\ To\ References          <Cmd>lua vim.fn.feedkeys("gr")<CR>
nnoremenu PopUp.Toggle\ Breakpoint          <Cmd>lua vim.fn.feedkeys("<A-d><A-b>")<CR>
nnoremenu PopUp.Open\ Debugger              <Cmd>lua require("dap").continue()<CR>
nnoremenu PopUp.Peek\ Value                 <Cmd>lua require("dapui").eval(nil, {enter = true})<CR>
anoremenu PopUp.-1-                         <Nop>
anoremenu PopUp.Exit                        <Nop>
]])
--- autocmds
-- vim.api.nvim_create_augroup("LspFormattingLua", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     group = "LspFormattingLua",
--     pattern = "*.lua",
--     callback = function()
--         vim.lsp.buf.format()
--     end
-- })
vim.api.nvim_create_augroup("MarkdownMagic", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = "MarkdownMagic",
    pattern = "*.md",
    callback = function()
        vim.wo.conceallevel = 2
        vim.wo.spell = true
    end
})
vim.api.nvim_create_autocmd({ "BufLeave" }, {
    group = "MarkdownMagic",
    pattern = "*.md",
    callback = function()
        vim.wo.conceallevel = 0
        vim.wo.spell = false
    end
})
vim.api.nvim_create_augroup("Oil", { clear = false })
vim.api.nvim_create_autocmd({ "BufLeave" }, {
    group = "Oil",
    pattern = "*",
    callback = function()
        if vim.o.filetype ~= "oil" then
            return
        end
        vim.o.number = true
        vim.o.relativenumber = true
    end
})
vim.api.nvim_create_augroup("FormatTelescope", { clear = true })
vim.api.nvim_create_autocmd('User', {
    pattern = "TelescopePreviewerLoaded",
    command = "setlocal wrap",
})
vim.api.nvim_create_augroup("FormatGroup", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = "FormatGroup",
    pattern = "*",
    callback = function()
        vim.cmd('set formatoptions-=cro')
        vim.cmd('setlocal formatoptions-=cro')
    end
})
vim.api.nvim_create_augroup("LaunchEnterGroup", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = "LaunchEnterGroup",
    pattern = { "*.launch", ".urdf", "*.xacro", "*.xml" },
    callback = function()
        vim.opt_local.filetype = "html"
    end
})
vim.api.nvim_create_augroup("MatchPairs", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = "MatchPairs",
    pattern = { "*.cpp", "*.h", "*.hpp", "*.c" },
    callback = function()
        vim.bo.matchpairs = "(:),{:},[:],<:>,=:;,"
    end
})
vim.api.nvim_create_augroup("LspFormatting", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = "LspFormatting",
    pattern = { "*.cpp", "*.h", "*.cxx", "*.hpp" },
    command = "ClangFormat",

})
local params = {
    command = 'pyright.organizeimports',
    arguments = { vim.uri_from_bufnr(0) },
}
vim.api.nvim_create_augroup("PythonFormatting", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = "PythonFormatting",
    pattern = "*.py",
    callback = function()
        vim.lsp.buf.execute_command(params)
    end
})

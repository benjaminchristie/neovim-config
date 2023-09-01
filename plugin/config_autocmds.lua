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
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*.cpp", "*.h", "*.cxx", "*.hpp" },
    command = "ClangFormat",
})

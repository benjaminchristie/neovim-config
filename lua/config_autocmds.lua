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
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.lua",
    callback = function()
        vim.lsp.buf.format()
    end
})
vim.api.nvim_create_augroup("Oil", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = "Oil",
    pattern = "*",
    callback = function()
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
if vim.fn.executable("black-macchiato") then
    local params = {
        command = 'pyright.organizeimports',
        arguments = { vim.uri_from_bufnr(0) },
    }
    vim.api.nvim_create_augroup("PythonFormatting", { clear = true })
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        group = "PythonFormatting",
        pattern = "*.py",
        callback = function()
            vim.bo.swapfile = false
            local line_num = vim.api.nvim_win_get_cursor(0)[1]
            local _pre = vim.api.nvim_buf_get_lines(0, 0, -1, false)
            local fn = vim.api.nvim_buf_get_name(0)
            vim.fn.jobstart("cat " .. fn .. " | black-macchiato",
                {
                    stdout_buffered = true,
                    stderr_buffered = true,
                    on_exit = function(_, code, _)
                        if code ~= 0 and vim.api.nvim_buf_get_name(0) == fn then -- ERROR, reset lines
                            vim.api.nvim_buf_set_lines(0, 0, -1, false, _pre)
                        end
                        vim.lsp.buf.execute_command(params)
                        vim.cmd(":" .. line_num)
                    end,
                    on_stdout = function(_, data)
                        if data and vim.api.nvim_buf_get_name(0) == fn then
                            table.remove(data, #data) -- black-macchiato adds an extra newline for some reason
                            vim.api.nvim_buf_set_lines(0, 0, -1, false, data)
                        end
                    end,
                }
            )
        end
    })
end

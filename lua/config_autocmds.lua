vim.api.nvim_create_augroup("FormatGroup", {clear = false})
vim.api.nvim_create_autocmd({"BufEnter"}, {
    group = "FormatGroup",
    pattern = "*",
    callback = function()
        vim.cmd('set formatoptions-=cro')
        vim.cmd('setlocal formatoptions-=cro')
    end
})
vim.api.nvim_create_augroup("LaunchEnterGroup", {clear = false})
vim.api.nvim_create_autocmd({"BufEnter"}, {
    group = "LaunchEnterGroup",
    pattern = {"*.launch", ".urdf", "*.xacro", "*.xml"},
    callback = function()
        vim.opt_local.filetype = "html"
    end
})
vim.api.nvim_create_augroup("ClangFormatGroup", {clear = false})
vim.api.nvim_create_autocmd({"BufWritePre"}, {
    group = "ClangFormatGroup",
    pattern = {"*.cpp", "*.h", "*.hpp", "*.c"},
    callback = function()
        vim.cmd("ClangFormat")
    end
})
if vim.fn.executable("black-macchiato") then
    local params = {
        command = 'pyright.organizeimports',
        arguments = { vim.uri_from_bufnr(0) },
    }
    vim.api.nvim_create_augroup("PythonFormatting", {clear = false})
    vim.api.nvim_create_autocmd({"BufWritePre"}, {
        group = "PythonFormatting",
        pattern = "*.py",
        callback = function ()
            vim.bo.swapfile = false
            local line_num = vim.api.nvim_win_get_cursor(0)[1]
            local _pre = vim.api.nvim_buf_get_lines(0, 0, -1, false)
            vim.fn.jobstart("cat ".. vim.api.nvim_buf_get_name(0) .." | black-macchiato",
                {
                    stdout_buffered = true,
                    stderr_buffered = true,
                    on_exit = function(_, code, _)
                        if code ~= 0 then  -- ERROR, reset lines
                            vim.api.nvim_buf_set_lines(0, 0, -1, false, _pre)
                        end
                        vim.lsp.buf.execute_command(params)
                        vim.cmd(":" .. line_num)
                    end,
                    on_stdout = function(_, data)
                        if data then
                            table.remove(data, #data)  -- black-macchiato adds an extra newline for some reason
                            vim.api.nvim_buf_set_lines(0, 0, -1, false, data)
                        end
                    end,
                }
            )
        end
    })
end
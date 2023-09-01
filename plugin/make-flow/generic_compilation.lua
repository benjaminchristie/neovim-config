------- Define parameters -----------
function CreateWin()
    local buf = vim.fn.bufadd("make-flow buffer")
    vim.fn.bufload(buf)
    vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
    -- vim.bo[buf].number = false
    -- vim.bo[buf].relativenumber = false
    -- vim.api.nvim_buf_set_option(buf, 'relativenumber', false)
    -- vim.api.nvim_buf_set_option(buf, 'number', false)
    return buf
end

function Compile(path, command, bufnr, timeout)
    if not vim.fn.bufexists(bufnr) then
        bufnr = CreateWin()
    end
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
        "Beginning compilation of " .. vim.fn.pathshorten(path)
    })
    vim.fn.jobstart(command,
        {
            stdout_buffered = true,
            stderr_buffered = true,
            on_exit = function(_, exitCode, _)
                if exitCode == 0 then
                    if vim.fn.bufexists(bufnr) then
                        vim.api.nvim_buf_set_lines(bufnr, 0, 1, false,
                            { "===Compilation Successful!===" })
                    end
                    -- begin deferral
                    vim.defer_fn(function()
                            if vim.api.nvim_buf_is_loaded(bufnr) then
                                -- if vim.fn.bufexists(bufnr) then
                                vim.api.nvim_buf_delete(bufnr, { force = true, unload = false })
                            end
                        end,
                        timeout
                    )
                else
                    vim.api.nvim_buf_set_lines(bufnr, 0, 1, false,
                        { "===Compilation Unsuccesful===" })
                end
            end,
            on_stdout = function(_, data)
                if data then
                    vim.api.nvim_buf_set_lines(bufnr, -1, -1, false,
                        data)
                else
                    vim.api.nvim_buf_set_lines(bufnr, -1, -1, false,
                        { "no output" })
                end
            end,
            on_stderr = function(_, data)
                if data then
                    vim.api.nvim_buf_set_lines(bufnr, -1, -1, false,
                        data)
                else
                    vim.api.nvim_buf_set_lines(bufnr, -1, -1, false,
                        { "no output" })
                end
            end
        })
end

function KillBuffer(bufnr)
    if vim.api.nvim_buf_is_loaded(bufnr) then
        vim.api.nvim_buf_delete(bufnr, { force = true, unload = false })
    end
end

return { killBuffer = KillBuffer, compile = Compile, createWin = CreateWin }

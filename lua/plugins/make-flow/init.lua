------- Define parameters -----------
local function createWin()
    local buf = vim.fn.bufadd("make-flow buffer")
    vim.fn.bufload(buf)
    vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
    return buf
end

local function compile(path, command, bufnr, timeout)
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

local function killBuffer(bufnr)
    if vim.api.nvim_buf_is_loaded(bufnr) then
        vim.api.nvim_buf_delete(bufnr, { force = true, unload = false })
    end
end

--- default parameters ---
local mk_timeout = 1000
local function compileCallback(filename, command, timeout)
    timeout = timeout or mk_timeout
    local bufnr = createWin()
    compile(filename,
        command,
        bufnr,
        timeout
    )
    local linecount = vim.api.nvim_win_get_height(0)
    local colcount = vim.api.nvim_win_get_width(0)
    vim.api.nvim_open_win(bufnr, false,
        {
            relative = 'editor',
            width = 60,
            height = 10,
            row = linecount,
            col = colcount,
            style = "minimal",
            border = "rounded"
        })
end
local function pandocCompile()
    local filename = vim.api.nvim_buf_get_name(0)
    compileCallback(filename, { "pandoc", filename, "-o", filename .. ".pdf" })
end
local function cppCompile()
    local filename = vim.api.nvim_buf_get_name(0)
    local CXXFLAGS = { "-O3", "-g" }
    compileCallback(filename, { "g++", filename
    , table.concat(CXXFLAGS, " "), "-o", filename .. ".out" })
end
local function makeUpfile()
    local filename = vim.api.nvim_buf_get_name(0)
    local idx = #filename - string.find(string.reverse(filename), "/") + 1
    local lfn = string.sub(filename, 0, idx)
    -- compileCallback(filename, {"make", "auto", "--silent", "-C", lfn })
    compileCallback(filename, { "make", "auto", "--silent", "-C", lfn })
end

local function kill()
    killBuffer(createWin())
end
local function pythonReindent()
    local filename = vim.api.nvim_buf_get_name(0)
    compileCallback(filename, { "reindent", filename })
end


------Begin parameters Section---------------------
mk_timeout = 1000
------Begin Keymappings Section--------------------

vim.keymap.set({ "n" }, "<C-l><C-p>", pandocCompile)
vim.keymap.set({ "n" }, "<C-l><C-c>", cppCompile)
vim.keymap.set({ "n" }, "<C-l><C-l>", makeUpfile)
vim.keymap.set({ "n" }, "<C-l><C-r>", pythonReindent)
vim.keymap.set({ "n" }, "<C-l><C-q>", kill)
-- vim.keymap.set({"n"}, "<C-k><C-q>", killBuffer)

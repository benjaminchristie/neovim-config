package.path = package.path .. ";/home/benjamin/.config/nvim/lua/plugins/make-flow/?.lua"
local actions = require("generic_compilation")
--- default parameters ---
local mk_timeout = 1000
local function compileCallback(filename, command, timeout)
    timeout = timeout or mk_timeout
    local bufnr = actions.createWin()
    actions.compile(filename,
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
local function killBuffer()
    actions.killBuffer(actions.createWin())
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
vim.keymap.set({ "n" }, "<C-l><C-q>", killBuffer)
-- vim.keymap.set({"n"}, "<C-k><C-q>", killBuffer)

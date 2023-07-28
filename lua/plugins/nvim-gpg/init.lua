package.path = package.path .. ";/home/benjamin/.config/nvim/lua/plugins/nvim-gpg/?.lua"
local M = {}
-- if not vim.fn.executable("gpg") then
--     print("gpg executable not found, not initializing nvim-gpg")
-- else -- initialize
M.Decrypt_command = "gpg -d --quiet"
M.Encrypt_command = "gpg -c --quiet"
M.augroup = vim.api.nvim_create_augroup("NvimGpgGroup", {clear = true})
function M.read_encrypted_file_lines()
    vim.fn.jobstart(M.Decrypt_command .. " " .. vim.api.nvim_buf_get_name(0), {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = function(_, data)
            if data then
                vim.api.nvim_buf_set_lines(0, 0, -1, false,
                    data)
            else
                print("No data read from decrypted file")
            end
        end,
        on_stderr = function (_, _)
            print("Error decrypting file")
        end,
    })
end
function M.write_encrypted_file_lines()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local raw = ""
    local newline_hash = "newline_hash_" .. vim.fn.reltimestr(vim.fn.reltime())
    for i = 1, #lines - 1, 1 do
        raw = raw .. lines[i] .. newline_hash
    end
    raw = raw .. lines[#lines]
    vim.cmd("silent !/home/benjamin/.config/nvim/lua/plugins/nvim-gpg/test.sh ".. raw .. " " .. vim.api.nvim_buf_get_name(0) .. " " .. newline_hash)
    vim.cmd("e!")
end
function M.GpgRead()
    M.read_encrypted_file_lines()
end
function M.GpgWrite()
    M.write_encrypted_file_lines()
end
vim.api.nvim_create_autocmd({"BufReadPre, FileReadPre"}, {
    group = M.augroup,
    pattern = "*.gpg",
    callback = function ()
        vim.bo.buftype = "nowrite"
        vim.o.winbar = "GPG File : " .. vim.fn.expand("%:f")
        vim.o.shada = false
        vim.bo.swapfile = false
        vim.bo.undofile = false
        vim.o.backup = false
        vim.bo.binary = true
        vim.bo.autoread = true
        M.GpgRead()
    end
})
vim.api.nvim_create_autocmd({"BufWritePre", "FileWritePre"}, {
    group = M.augroup,
    pattern = "*.gpg",
    callback = function ()
        vim.bo.buftype = "nowrite"
        vim.o.winbar = "GPG File : " .. vim.fn.expand("%:f")
        vim.o.shada = false
        vim.bo.swapfile = false
        vim.bo.undofile = false
        vim.o.backup = false
        vim.bo.binary = true
        vim.bo.autoread = true
        M.GpgWrite()
    end
})
vim.api.nvim_create_user_command("GpgRead", M.GpgRead, {})
vim.api.nvim_create_user_command("GpgWrite", M.GpgWrite, {})


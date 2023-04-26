require("gitsigns").setup()
vim.o.showtabline = 1
local force_inactive_filetypes = {
  'NvimTree',
  'dbui',
  'packer',
  'startify',
  'fugitive',
  'fugitiveblame',
  'nofile',
  'toggleterm',
  'terminal',
  'starter',
  'qf',
  ""
}

local force_inactive_buftypes = {
  'terminal',
  'toggleterm',
  'nofile',
  'quickfix',
  'nowrite'
}

local function hasvalue(table, value)
    for _, val in ipairs(table) do
    	if val == value then
    		return true
    	end
    end
    return false
end
local function winbarstring()
    local path = vim.fn.pathshorten(vim.fn.expand("%:f"))
    local branch = vim.b.gitsigns_head
    if branch ~= nil then
            local hunks_tb = require("gitsigns").get_hunks(vim.api.nvim_get_current_buf())
            local added_count = "0"
            local removed_count = "0"
            if hunks_tb ~= nil then
                for _, hunks in pairs(hunks_tb) do
                    if hunks["added"] ~= nil then
                        added_count = hunks["added"]["count"]
                    end
                    if hunks["removed"] ~= nil then
                        removed_count = hunks["removed"]["count"]
                    end
                end
            end
	    return string.format(path .. "    " .. branch .. ": +" .. added_count .. " -" .. removed_count)
    else
	    return string.format(path)
    end
end
vim.api.nvim_create_autocmd('User', {
    pattern = 'GitSignsUpdate',
    callback = function()
	if hasvalue(force_inactive_buftypes, vim.bo.buftype) or hasvalue(force_inactive_filetypes, vim.bo.filetype) then
	    vim.opt_local.winbar = nil
	else
	    vim.opt_local.winbar = winbarstring()
	end
    end
})
vim.api.nvim_create_autocmd({"BufWinEnter", "DirChanged"}, {
    pattern = "*",
    callback = function()
	if hasvalue(force_inactive_buftypes, vim.bo.buftype) or hasvalue(force_inactive_filetypes, vim.bo.filetype) then
	    vim.opt_local.winbar = nil
	else
	    vim.opt_local.winbar = winbarstring()
	end
    end
})
vim.o.laststatus = 3
vim.o.statusline = "%y - %l/%L - b%n"

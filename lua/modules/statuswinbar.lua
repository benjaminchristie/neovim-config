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
  'starter'
}
local force_inactive_buftypes = {
  'terminal',
  'toggleterm'
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
    local path = vim.fn.pathshorten(vim.fn.expand("%:~:f"))
    local branch = vim.g.gitsigns_head
    if branch ~= nil then
	    return string.format(path.." : "..branch)
    else
	    return string.format(path)
    end
end
vim.api.nvim_create_autocmd('User', {
    pattern = 'GitSignsUpdate',
    callback = function()
	if hasvalue(force_inactive_buftypes, vim.bo.buftype) or hasvalue(force_inactive_filetypes, vim.bo.filetype) then
	    return
	else
	    vim.opt_local.winbar = winbarstring()
	end
    end
})
vim.api.nvim_create_autocmd({"BufWinEnter"}, {
    pattern = "*",
    callback = function()
	if hasvalue(force_inactive_buftypes, vim.bo.buftype) or hasvalue(force_inactive_filetypes, vim.bo.filetype) then
	    return
	else
	    vim.opt_local.winbar = winbarstring()
	end
    end
})

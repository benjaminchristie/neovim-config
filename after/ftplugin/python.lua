vim.keymap.set('n', "<A-f>", function()
	local params = {
		command = 'pyright.organizeimports',
		arguments = { vim.uri_from_bufnr(0) },
	}
	vim.lsp.buf.execute_command(params)
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
end)
vim.bo.softtabstop = 8
vim.bo.expandtab = true
vim.bo.tabstop = 8

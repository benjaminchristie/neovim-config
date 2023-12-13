return {
	'chrisbra/unicode.vim',
	event = 'VeryLazy',
	config = function()
		vim.g.Unicode_no_default_mappings = true
		vim.g.Unicode_ShowPreviewWindow = true
	end,
	cmd = {
		"Digraphs",
		"UnicodeSearch",
		"UnicodeName",
		"UnicodeTable",
		"DownloadUnicode",
		"UnicodeCache",
	},
	dependencies = {
		'ibhagwan/fzf-lua',
	},
	keys = {
		{
			"<C-p><C-u>",
			function()
				local unicode_filename = vim.fn.stdpath("data") .. "/site/unicode/UnicodeData.txt"
				require("fzf-lua").fzf_exec("cat " .. unicode_filename, {
					actions = {
						['default'] = function(selected)
							local str = selected[#selected]
							local idx = string.find(str, ";")
							local hex = string.sub(str, 1, idx - 1)
							vim.api.nvim_feedkeys(
								vim.api.nvim_replace_termcodes("<esc>i<c-v>u" .. hex, true, false, true), 'm', true
							)
						end
					},
					prompt = "Unicode> ",
				})
			end,
			mode = { "i", "n" },
		},
	}
}

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
				local script = [[sed -e 's/\([0-9A-Fa-f]\{4,5\}\);/\\u\0 \1/' <]] .. unicode_filename .. [[| while read -r line;do echo -e "$line";done]]
				require("fzf-lua").fzf_exec(script, {
					actions = {
						['default'] = function(selected)
							local str = selected[#selected]
							local char = string.sub(str, 1, 2)
							vim.api.nvim_feedkeys(
								vim.api.nvim_replace_termcodes("<esc>i" .. char, true, false, true), 'm', true
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

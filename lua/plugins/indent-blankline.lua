return {
	'lukas-reineke/indent-blankline.nvim',
	main = "ibl",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		scope = {
			enabled = true,
			show_start = false,
			show_end = false
		},
		indent = { smart_indent_cap = true },
	},
	enabled = false,
	-- opts = {
	-- 	scope = {
	-- 		enabled = true,
	-- 		show_start = false,
	-- 		show_end = false,
	-- 		highlight = "IndentBlanklineContextChar"
	-- 	},
	-- 	whitespace = {
	-- 		remove_blankline_trail = true
	-- 	},
	-- 	indent = {
	-- 		char = '│',
	-- 		smart_indent_cap = true,
	-- 	}
	-- },
}

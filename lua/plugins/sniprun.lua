return {
    'michaelb/sniprun',
    build = "sh install.sh",
    cmd = "SnipRun",
	opts = {
		display = {"Terminal"},
		display_options = {
		  terminal_line_number = false, -- whether show line number in terminal window
		  terminal_signcolumn = false, -- whether show signcolumn in terminal window
		  terminal_width = 50,       -- change the terminal display option width
		},
	}
}

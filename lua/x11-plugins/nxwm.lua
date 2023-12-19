return {
	"altermo/nxwm",
	enabled = true,
	lazy = false,
	priority = 1000,
	opts = {
		autofocus = true,
		on_win_open = function (buf, xwin)
			vim.cmd.vsplit()
			vim.api.nvim_set_current_buf(buf)
			vim.cmd([[!setxkbmap -option caps:swapescape && xmodmap -e "keycode 108 = Super_L" && xmodmap -e "remove mod1 = Super_L" && xset r rate 200 100]])
		end,
	}
}

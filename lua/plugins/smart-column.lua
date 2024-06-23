return {
    "benjaminchristie/smartcolumn.nvim",
    opts = {
        colorcolumn = "120",
		custom_colorcolumn = function ()
			if require("functions").zen_enabled() then
				return "0"
			else
				return "120"
			end
		end,
        scope = "line",
        disabled_filetypes = {
            "lazy",
            "terminal",
            "help",
            "starter",
            "tex",
            "DiffviewFileHistory",
        }
    },
    event = {"BufReadPre", "BufNewFile"},
    dev = false,
}

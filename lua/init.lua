require("impatient")
-- require("plugins")
require("colors")
local async
async =
    vim.loop.new_async(
    vim.schedule_wrap(
        function()
            require("options")
            require("config")
	    require("harpoon").setup({})
            require("modules/cmp-init")
            require("modules/tree-init")
            require("modules/stay-init")
            require("modules/task-init")
            require("plugins.make-flow")
	    require('colorizer').setup({}, { css = true; })
	    require('easyread').setup({})
	    require('mini.pairs').setup()
            async:close()
        end
    )
)

async:send()
-- for some reason, some LSP servers do not attach to files properly if loaded asynchronously 
require("modules/lsp-init")
require("modules/statuswinbar")
require("nvim-surround").setup()
require("nvim-surround").buffer_setup {
    surrounds = {
	["c"] = {
	    add = function()
		local cmd = require("nvim-surround.config").get_input "Command: "
		return { { "\\" .. cmd .. "{" }, { "}" } }
	    end,
	},
	["e"] = {
	    add = function()
		local env = require("nvim-surround.config").get_input "Environment: "
		return { { "\\begin{" .. env .. "}" }, { "\\end{" .. env .. "}" } }
	    end,
	},
    },
}

require('mini.starter').setup()
-- require('dashboard').setup()

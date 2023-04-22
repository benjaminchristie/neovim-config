require("impatient")
require("colors")
-- require("plugins")
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
-- for some reason, some LSP servers do not attach to files properly if loaded asynchronously 

require("modules/lsp-init")
local starter = require('mini.starter')
starter.setup({
    evaluate_single = false,
    items = {
      starter.sections.builtin_actions(),
      starter.sections.recent_files(5, false),
      starter.sections.telescope(),
    },
    content_hooks = {
      starter.gen_hook.adding_bullet(),
      starter.gen_hook.aligning("center", "center")
      -- starter.gen_hook.padding(3, 2),
    },
})
-- -- require('dashboard').setup()

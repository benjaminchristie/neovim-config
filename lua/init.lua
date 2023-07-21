vim.loader.enable()
require("modules/starter")
require("colors")
require("options")
require("config")
require("harpoon").setup({})
require("modules/cmp-init")
require("modules/tree-init")
require("modules/treesitter-init")
require("modules/stay-init")
require("modules/task-init")
require("modules/telescope")
require("modules/undotree")
require("plugins.make-flow")
require('colorizer').setup({}, { css = true; })
-- require('mini.pairs').setup()
require('nvim-autopairs').setup({
    ignored_next_char = "[%w%.]",
    enable_check_bracket_line = false,
})
require('nvim-ts-autotag').setup()
require("modules/statuswinbar")
require("modules/surround")
require("modules/lsp-init")
require("modules/term")
require("modules/gdb")
require("oil").setup()
require("gitsigns").setup({
    numhl = false,
    current_line_blame = false,
    current_line_blame_opts = {
        delay = 0,
        virt_text_pos = "right_align",
        ignore_whitespace = true,
    },
    current_line_blame_formatter = " <author>, <author_time> - <abbrev_sha> - <summary>  "
})

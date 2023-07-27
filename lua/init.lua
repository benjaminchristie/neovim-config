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
require('colorizer').setup({}, { css = true; })
require('nvim-autopairs').setup({
    ignored_next_char = "[%w%.]",
    enable_check_bracket_line = false,
})
require('nvim-ts-autotag').setup({
    filetypes = {"html", "xml"}
})
require("modules/statuswinbar")
require("modules/surround")
require("modules/lsp-init")
require("modules/term")
require("modules/gdb")
require("oil").setup()
require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = false,
}
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
require("plugins.nvim-gpg")
require("plugins.make-flow")

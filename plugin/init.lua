require("highlight-undo").setup({})
require("early-retirement").setup({
    retirementAgeMins = 10,
    ignoreVisibileBufs = false,
    notificationOnAutoClose = false,
})
require("oil").setup({
    columns = {
        "icon"
    },
    win_options = {
        conceallevel = 3,
    },
    skip_confirm_for_simple_edits = true,
    prompt_save_on_select_new_entry = false,
    keymaps = {
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-s>"] = "actions.select_split",
        ["<C-h>"] = "actions.toggle_hidden",
        ["<C-t>"] = "actions.select_tab",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["<C-p>"] = "actions.preview",
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
    },
    use_default_keymaps = false,
    view_options = {
        is_hidden_file = function(name, _)
            return vim.startswith(name, ".") and not vim.startswith(name, ".gitignore")
        end
    }
})
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

require("perfanno").setup {
    line_highlights = require("perfanno.util").make_bg_highlights("#1A1B26", "#CC3300", 10),
    vt_highlight = require("perfanno.util").make_fg_highlight("#CC3300"),
    annotate_after_load = true,
    annotate_on_open = true,
    ts_function_patterns = {
        default = {
            "function",
            "method",
        },
    },
}
require('nvim-ts-autotag').setup({
    filetypes = { "html", "xml" }
})
require('remember')
require("nvim-lightbulb").setup({
    hide_in_unfocused_buffer = false,
    sign = {
        enabled = true,
        text = "💡",
        hl = "LightBulbSign",
    },
    autocmd = {
        enabled = true,
        updatetime = 10
    },
    ignore = {
        clients = {
            "lua_ls"
        }
    }
})
require("godbolt").setup({
    languages = {
        cpp = { compiler = "g122", options = {} },
        c = { compiler = "cg122", options = {} },
        rust = { compiler = "r1650", options = {} },
        -- any_additional_filetype = { compiler = ..., options = ... },
    },
    quickfix = {
        enable = false,         -- whether to populate the quickfix list in case of errors
        auto_open = false       -- whether to open the quickfix list in case of errors
    },
    url = "https://godbolt.org" -- can be changed to a different godbolt instance
})

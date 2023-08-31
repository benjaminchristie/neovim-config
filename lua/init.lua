require("config")
require("colors")
require("options")
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
require("plugins.nvim-gpg")
require("plugins.make-flow")
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
-- require'marks'.setup {
--   -- whether to map keybinds or not. default true
--   default_mappings = true,
--   -- which builtin marks to show. default {}
--   builtin_marks = { ".", "<", ">", "^" },
--   -- whether movements cycle back to the beginning/end of buffer. default true
--   cyclic = true,
--   -- whether the shada file is updated after modifying uppercase marks. default false
--   force_write_shada = false,
--   -- how often (in ms) to redraw signs/recompute mark positions.
--   -- higher values will have better performance but may cause visual lag,
--   -- while lower values may cause performance penalties. default 150.
--   refresh_interval = 250,
--   -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
--   -- marks, and bookmarks.
--   -- can be either a table with all/none of the keys, or a single number, in which case
--   -- the priority applies to all marks.
--   -- default 10.
--   sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
--   -- disables mark tracking for specific filetypes. default {}
--   excluded_filetypes = {},
--   -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
--   -- sign/virttext. Bookmarks can be used to group together positions and quickly move
--   -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
--   -- default virt_text is "".
--   bookmark_0 = {
--     sign = "⚑",
--     virt_text = "hello world",
--     -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
--     -- defaults to false.
--     annotate = false,
--   },
--   mappings = {}
-- }

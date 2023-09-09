local modules = {
    {
        'lewis6991/gitsigns.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            local opts = {
                numhl = false,
                current_line_blame = false,
                current_line_blame_opts = {
                    delay = 0,
                    virt_text_pos = "right_align",
                    ignore_whitespace = true,
                },
                current_line_blame_formatter = " <author>, <author_time> - <abbrev_sha> - <summary>  "
            }
            local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
            local gs = require("gitsigns").setup(opts)

            local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)

            vim.keymap.set({ "n", "x", "o" }, "]g", next_hunk_repeat)
            vim.keymap.set({ "n", "x", "o" }, "[g", prev_hunk_repeat)

            local is_gitsigns_toggled = false
            vim.keymap.set('n', 'gst', function()
                is_gitsigns_toggled = not is_gitsigns_toggled
                require("gitsigns").toggle_current_line_blame(is_gitsigns_toggled)
                require("gitsigns").toggle_linehl(is_gitsigns_toggled)
                require("gitsigns").toggle_deleted(is_gitsigns_toggled)
                require("gitsigns").toggle_numhl(is_gitsigns_toggled)
            end, { desc = "toggle gitsigns blame and buffer changes" })
        end,
        keys = {
            {'gss', function() return require("gitsigns").stage_hunk() end, { desc = "gitsigns stage hunk" }},
            {'gsa', function() return require("gitsigns").stage_buffer() end, { desc = "gitsigns stage buffer" }},
            {'gsr', function() return require("gitsigns").reset_hunk() end, { desc = "gitsigns reset hunk" }},
        }
    },
    {
        'tpope/vim-fugitive',
        lazy = false
    },
    {
        'sindrets/diffview.nvim',
        config = function()
            local actions = require('diffview.actions')
            local statuswinbar = require("statuswinbar")
            require("diffview").setup({
                enhanced_diff_hl = true, -- See |diffview-config-enhanced_diff_hl|
                hooks = {
                    view_opened = statuswinbar.in_diffview_hook,
                    view_closed = statuswinbar.out_diffview_hook,
                },
                view = {
                    default = {
                        -- Config for changed files, and staged files in diff views.
                        layout = "diff2_horizontal",
                        winbar_info = true, -- See |diffview-config-view.x.winbar_info|
                    },
                    merge_tool = {
                        -- Config for conflicted files in diff views during a merge or rebase.
                        layout = "diff3_horizontal",
                        disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
                        winbar_info = true, -- See |diffview-config-view.x.winbar_info|
                    },
                    file_history = {
                        -- Config for changed files in file history views.
                        layout = "diff2_horizontal",
                        winbar_info = true, -- See |diffview-config-view.x.winbar_info|
                    },
                },
                keymaps = {
                    disable_defaults = true,
                    view = {
                        { "n", "gf",    actions.goto_file_edit,            { desc =
                        "Open the file in the previous tabpage" } },
                        { "n", "[x",    actions.prev_conflict,
                                                                               { desc =
                            "In the merge-tool: jump to the previous conflict" } },
                        { "n", "]x",    actions.next_conflict,             { desc =
                        "In the merge-tool: jump to the next conflict" } },
                        { "n", "dh",    actions.conflict_choose("ours"),
                                                                               { desc =
                            "Choose the OURS version of a conflict" } },
                        { "n", "dl",    actions.conflict_choose("theirs"),
                                                                               { desc =
                            "Choose the THEIRS version of a conflict" } },
                        { "n", "g?",    actions.help({ "view", "diff3" }), { desc = "Open the help panel" } },
                        { "n", "<C-f>", actions.focus_files,               { desc = "Bring focus to the file panel" } },
                    },
                    diff3 = {
                        { { "n", "x" }, "dh", actions.diffget("ours"),
                                                                                     { desc =
                            "Obtain the diff hunk from the OURS version of the file" } },
                        { { "n", "x" }, "dl", actions.diffget("theirs"),
                                                                                     { desc =
                            "Obtain the diff hunk from the THEIRS version of the file" } },
                        { "n",          "g?", actions.help({ "view", "diff3" }), { desc = "Open the help panel" } },
                    },
                    file_panel = {
                        { "n", "[x",      actions.prev_conflict,
                                                                          { desc =
                            "In the merge-tool: jump to the previous conflict" } },
                        { "n", "]x",      actions.next_conflict,
                                                                          { desc =
                            "In the merge-tool: jump to the next conflict" } },
                        { "n", "<tab>",   actions.select_next_entry,  { desc = "Open the diff for the next file" } },
                        { "n", "<s-tab>", actions.select_prev_entry,  { desc = "Open the diff for the previous file" } },
                        { "n", "<cr>",    actions.select_entry,       { desc = "Open the diff for the selected entry" } },
                        { "n", "g?",      actions.help("file_panel"), { desc = "Open the help panel" } },
                        { "n", "L",       actions.open_commit_log,    { desc = "Show commit details" } },
                        { "n", "j",       actions.next_entry,         { desc = "Bring the cursor to the next file entry" } },
                        { "n", "<down>",  actions.next_entry,         { desc = "Bring the cursor to the next file entry" } },
                        { "n", "k",       actions.prev_entry,         { desc =
                        "Bring the cursor to the previous file entry" } },
                        { "n", "<up>",    actions.prev_entry,         { desc =
                        "Bring the cursor to the previous file entry" } },
                        { "n", "zR",      actions.open_all_folds,     { desc = "Expand all folds" } },
                        { "n", "zM",      actions.close_all_folds,    { desc = "Collapse all folds" } },
                    },
                    file_history_panel = {
                        { "n", "L",       actions.open_commit_log,    { desc = "Show commit details" } },
                        { "n", "g!",      actions.options,            { desc = "Open the option panel" } },
                        { "n", "<tab>",   actions.select_next_entry,  { desc = "Open the diff for the next file" } },
                        { "n", "<s-tab>", actions.select_prev_entry,  { desc = "Open the diff for the previous file" } },
                        { "n", "<cr>",    actions.select_entry,       { desc = "Open the diff for the selected entry" } },
                        { "n", "g?",      actions.help("file_panel"), { desc = "Open the help panel" } },
                        { "n", "j",       actions.next_entry,         { desc = "Bring the cursor to the next file entry" } },
                        { "n", "<down>",  actions.next_entry,         { desc = "Bring the cursor to the next file entry" } },
                        { "n", "k",       actions.prev_entry,         { desc =
                        "Bring the cursor to the previous file entry" } },
                        { "n", "<up>",    actions.prev_entry,         { desc =
                        "Bring the cursor to the previous file entry" } },
                        { "n", "zR",      actions.open_all_folds,     { desc = "Expand all folds" } },
                        { "n", "zM",      actions.close_all_folds,    { desc = "Collapse all folds" } },
                    },
                    option_panel = {
                        { "n", "<tab>", actions.select_entry,         { desc = "Change the current option" } },
                        { "n", "q",     actions.close,                { desc = "Close the panel" } },
                        { "n", "g?",    actions.help("option_panel"), { desc = "Open the help panel" } },
                    },
                    help_panel = {
                        { "n", "q",     actions.close, { desc = "Close help menu" } },
                        { "n", "<esc>", actions.close, { desc = "Close help menu" } },
                    },
                }
            })
        end,
        cmd = {"DiffviewOpen", "DiffviewFileHistory"},
        keys = {
            {"gV", ":DiffviewOpen<CR>"}, {"gM", ":DiffviewOpen<CR>"}, {"gsov", ":DiffviewFileHistory<CR>" }},
    },

}
return modules

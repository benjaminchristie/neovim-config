local actions = require('diffview.actions')
require("diffview").setup({
    enhanced_diff_hl = true, -- See |diffview-config-enhanced_diff_hl|
    view = {
        default = {
          -- Config for changed files, and staged files in diff views.
          layout = "diff2_horizontal",
          winbar_info = false,          -- See |diffview-config-view.x.winbar_info|
        },
        merge_tool = {
          -- Config for conflicted files in diff views during a merge or rebase.
          layout = "diff3_horizontal",
          disable_diagnostics = true,   -- Temporarily disable diagnostics for conflict buffers while in the view.
          winbar_info = false,           -- See |diffview-config-view.x.winbar_info|
        },
        file_history = {
          -- Config for changed files in file history views.
          layout = "diff2_horizontal",
          winbar_info = false,          -- See |diffview-config-view.x.winbar_info|
        },
    },
    keymaps = {
        disable_defaults = true,
        view = {
            { "n", "dh",  actions.conflict_choose("ours"),        { desc = "Choose the OURS version of a conflict" } },
            { "n", "dl",  actions.conflict_choose("theirs"),      { desc = "Choose the THEIRS version of a conflict" } },
            { "n", "g?",   actions.help({ "view", "diff3" }),  { desc = "Open the help panel" } },
            { "n", "<C-f>",   actions.focus_files,                    { desc = "Bring focus to the file panel" } },
        },
        diff3 = {
            { { "n", "x" }, "dh",  actions.diffget("ours"),            { desc = "Obtain the diff hunk from the OURS version of the file" } },
            { { "n", "x" }, "dl",  actions.diffget("theirs"),          { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
            { "n",          "g?",   actions.help({ "view", "diff3" }),  { desc = "Open the help panel" } },
        },
        file_panel = {
            { "n", "<tab>",          actions.select_next_entry,              { desc = "Open the diff for the next file" } },
            { "n", "<s-tab>",        actions.select_prev_entry,              { desc = "Open the diff for the previous file" } },
            { "n", "<cr>",           actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
            { "n", "g?",             actions.help("file_panel"),             { desc = "Open the help panel" } },
            { "n", "j",              actions.next_entry,                     { desc = "Bring the cursor to the next file entry" } },
            { "n", "<down>",         actions.next_entry,                     { desc = "Bring the cursor to the next file entry" } },
            { "n", "k",              actions.prev_entry,                     { desc = "Bring the cursor to the previous file entry" } },
            { "n", "<up>",           actions.prev_entry,                     { desc = "Bring the cursor to the previous file entry" } },
        },
        file_history_panel = {
            { "n", "<tab>",          actions.select_next_entry,              { desc = "Open the diff for the next file" } },
            { "n", "<s-tab>",        actions.select_prev_entry,              { desc = "Open the diff for the previous file" } },
            { "n", "<cr>",           actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
            { "n", "g?",             actions.help("file_panel"),             { desc = "Open the help panel" } },
            { "n", "j",              actions.next_entry,                     { desc = "Bring the cursor to the next file entry" } },
            { "n", "<down>",         actions.next_entry,                     { desc = "Bring the cursor to the next file entry" } },
            { "n", "k",              actions.prev_entry,                     { desc = "Bring the cursor to the previous file entry" } },
            { "n", "<up>",           actions.prev_entry,                     { desc = "Bring the cursor to the previous file entry" } },
        }
    }
})

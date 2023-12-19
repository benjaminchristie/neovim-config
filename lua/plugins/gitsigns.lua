return {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
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
        local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
        local gs = require("gitsigns")
        gs.setup(opts)

        local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk,
            gs.prev_hunk)

        require("utils").keymap({ "n", "x", "o" }, "]g", next_hunk_repeat)
        require("utils").keymap({ "n", "x", "o" }, "[g", prev_hunk_repeat)

        local is_gitsigns_toggled = false
        require("utils").keymap('n', 'gst', function()
            is_gitsigns_toggled = not is_gitsigns_toggled
            require("gitsigns").toggle_current_line_blame(is_gitsigns_toggled)
            require("gitsigns").toggle_linehl(is_gitsigns_toggled)
            require("gitsigns").toggle_deleted(is_gitsigns_toggled)
            require("gitsigns").toggle_numhl(is_gitsigns_toggled)
        end)
    end,
    keys = {
        { 'gss', function() return require("gitsigns").stage_hunk() end,   { desc = "gitsigns stage hunk" } },
        { 'gsa', function() return require("gitsigns").stage_buffer() end, { desc = "gitsigns stage buffer" } },
        { 'gsr', function() return require("gitsigns").reset_hunk() end,   { desc = "gitsigns reset hunk" } },
    }
}

return {
    'stevearc/oil.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
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
    },
    lazy = false,
    cmd = "Oil"
}

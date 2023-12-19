return {
    'stevearc/oil.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    init = function()
        local opts = {
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
        }
        require("oil").setup(opts)

        vim.api.nvim_create_user_command("Ex", function()
            local HEIGHT = 12
            vim.cmd("topleft Oil")
            vim.wo.number = false
            vim.wo.relativenumber = false
            vim.api.nvim_win_set_height(0, HEIGHT)
        end, { desc = "open oil above" })

        vim.api.nvim_create_user_command("Lex", function()
            local WIDTH = 45
            vim.cmd("vertical Oil")
            vim.wo.number = false
            vim.wo.relativenumber = false
            vim.api.nvim_win_set_width(0, WIDTH)
        end, { desc = "open oil above" })

        vim.api.nvim_create_user_command("Rex", function()
            local WIDTH = 45
            vim.o.splitright = false
            vim.cmd("vertical Oil")
            vim.o.splitright = true
            vim.wo.number = false
            vim.wo.relativenumber = false
            vim.api.nvim_win_set_width(0, WIDTH)
        end, { desc = "open oil to the left" })

    end,
    lazy = false,
    dev = false,
    cmd = "Oil"
}

require("nvim-tree").setup{

    -- hijack_netrw = true,
    disable_netrw = false,
    --vim.g.nvim_tree_disable_netrw = 0
    git = {
        ignore = true,
    },
    view = {
        adaptive_size = true,
    },
    renderer = {

        add_trailing = true,
        highlight_opened_files = "all",

    }

}

vim.g.nvim_tree_disable_netrw = 0

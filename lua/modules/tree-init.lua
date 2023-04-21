require("nvim-tree").setup{

    hijack_netrw = true,
    disable_netrw = true,
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


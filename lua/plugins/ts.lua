return {
    "nvim-treesitter/nvim-treesitter",

    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
		require("nvim-treesitter.install").prefer_git = true
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "bash",
                "c",
                "html",
                "javascript",
                "jsdoc",
                "json",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
            },
            auto_install = true,
            highlight = {
                enable = true,
                disable = { "tex", "latex" },
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = 'gnn',
                    scope_incremental = '<CR>',
                    node_incremental = '<TAB>',
                    node_decremental = '<S-TAB>',
                }
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ['al'] = '@loop.outer',
                        ['il'] = '@loop.inner',
                    }
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        [']f'] = '@function.outer',
                        [']if'] = '@function.inner',
                        [')'] = '@parameter.inner',
                        [']c'] = '@call.outer',
                        [']ic'] = '@call.inner',
                    },
                    goto_next_end = {
                        [']F'] = '@function.outer',
                        [']iF'] = '@function.inner',
                        ['g)'] = '@parameter.inner',
                        [']C'] = '@call.outer',
                        [']iC'] = '@call.inner',
                    },
                    goto_previous_start = {
                        ['[f'] = '@function.outer',
                        ['[if'] = '@function.inner',
                        ['('] = '@parameter.inner',
                        ['[c'] = '@call.outer',
                        ['[ic'] = '@call.inner',
                    },
                    goto_previous_end = {
                        ['[F'] = '@function.outer',
                        ['[iF'] = '@function.inner',
                        ['g('] = '@parameter.inner',
                        ['[C'] = '@call.outer',
                        ['[iC'] = '@call.inner',
                    },
                }
            }
        })
    end
}

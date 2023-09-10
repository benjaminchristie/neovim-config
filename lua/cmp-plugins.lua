local modules = {
    {
        'hrsh7th/cmp-nvim-lsp',
        event = "VeryLazy"
    },
    {
        'L3MON4D3/LuaSnip',
        event = "VeryLazy",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        keys = {
            {
                "<tab>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                end,
                expr = true,
                silent = true,
                mode = "i",
            },
            {
                "<s-tab>",
                function()
                    return require("luasnip").jumpable(-1) and "<Plug>luasnip-jump-prev" or "<s-tab>"
                end,
                expr = true,
                silent = true,
                mode = "i",
            },
            { "<tab>",   function() require("luasnip").jump(1) end,  mode = { "s" } },
            { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "s" } },
        },
    },
    {
        "rafamadriz/friendly-snippets",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
        event = "VeryLazy",
    },
    {
        'hrsh7th/cmp-buffer',
        event = "VeryLazy"
    },
    {
        'hrsh7th/cmp-cmdline',
        event = "VeryLazy"
    },
    {
        'saadparwaiz1/cmp_luasnip',
        event = "VeryLazy",
    },
    {
        'petertriho/cmp-git',
        event = "VeryLazy"
    },
    {
        'hrsh7th/cmp-path',
        event = "VeryLazy"
    },
    {
        'hrsh7th/nvim-cmp',
        commit = '969c5a', -- for some reason, ghost test does not work for me after this commit
        dependencies = {
            'L3MON4D3/LuaSnip',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'saadparwaiz1/cmp_luasnip',
            'petertriho/cmp-git',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            -- Setup nvim-cmp.
            vim.o.completeopt = "menu,menuone,preview"
            local cmp = require('cmp')
            local luasnip = require("luasnip")
            require("cmp_git").setup()
            local opts = {
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                window = {
                    completion = {
                        border = nil,
                    },
                    documentation = {
                        border = nil,
                    },
                },
                mapping = cmp.mapping.preset.insert({
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = 'luasnip' }, -- For luasnip users.
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                    { name = 'buffer' },
                    -- {
                    --     name = 'dictionary',
                    --     keyword_length = 2,
                    -- },
                }),
                matching = {
                    disallow_fuzzy_matching = false,
                    disallow_fullfuzzy_matching = false,
                    disallow_partial_fuzzy_matching = false,
                    disallow_partial_matching = false,
                    disallow_prefix_unmatching = false,
                },
                experimental = {
                    ghost_text = {
                        hl_group = "GhostText"
                    }
                },
                sorting = require("cmp.config.default")().sorting
            }
            cmp.setup(opts)
            -- Set configuration for specific filetype.
            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'cmp_git' },
                    { name = 'buffer' },
                })
            })

            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                }
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                })
            })
        end,
        event = { "InsertEnter", "CmdlineEnter" }
    },
}
return modules

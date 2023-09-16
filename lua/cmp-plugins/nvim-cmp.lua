return {
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
        require("cmp_git").setup()
        local opts = {
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
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
                -- Accept currently selected item. 
                -- Set `select` to `false` to only confirm explicitly selected items.
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif require("luasnip").expand_or_jumpable() then
                        require("luasnip").expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif require("luasnip").jumpable(-1) then
                        require("luasnip").jump(-1)
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
                { name = 'path' },
				{
				  name = 'cmdline',
				  keyword_length = 3,
				  option = {
					ignore_cmds = { 'Man', '!' }
				  }
				}
            })
        })
    end,
    -- this is a temporary work around
    -- event = { "BufReadPre", "BufNewFile", "CmdLineEnter" },
    event = { "CursorMoved", "BufReadPre", "BufNewFile", "CmdLineEnter" },
}

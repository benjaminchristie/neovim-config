local modules = {
    { 'kevinhwang91/promise-async' },
    {
        "kevinhwang91/nvim-fundo",
        dependencies = { 'kevinhwang91/promise-async' },
        build = function()
            require("fundo").install()
        end,
        lazy = false,
    },
    {
        'tzachar/highlight-undo.nvim',
        dependencies = { "folke/tokyonight.nvim" },
        opts = {
            duration = 300,
            undo = {
                hlgroup = 'HighlightUndo',
                mode = 'n',
                lhs = 'u',
                map = 'undo',
                opts = {}
            },
            redo = {
                hlgroup = 'HighlightUndo',
                mode = 'n',
                lhs = '<C-r>',
                map = 'redo',
                opts = {}
            },
            highlight_for_count = true,
        },
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        'windwp/nvim-autopairs',
        config = function()
            local Rule = require('nvim-autopairs.rule')
            local npairs = require('nvim-autopairs')
            local cond = require('nvim-autopairs.conds')
            -- local ts_conds = require('nvim-autopairs.ts-conds')

            local function quote_creator(opt)
                local quote = function(...)
                    local move_func = opt.enable_moveright and cond.move_right or cond.none
                    local rule = Rule(...):with_move(move_func()):with_pair(cond.not_add_quote_inside_quote())

                    if #opt.ignored_next_char > 1 then
                        rule:with_pair(cond.not_after_regex(opt.ignored_next_char))
                    end
                    rule:use_undo(opt.break_undo)
                    return rule
                end
                return quote
            end

            local function bracket_creator(opt)
                local quote = quote_creator(opt)
                local bracket = function(...)
                    local rule = quote(...)
                    if opt.enable_check_bracket_line == true then
                        rule:with_pair(cond.is_bracket_line()):with_move(cond.is_bracket_line_move())
                    end
                    if opt.enable_bracket_in_quote then
                        -- still add bracket if text is quote "|" and next_char have "
                        rule:with_pair(cond.is_bracket_in_quote(), 1)
                    end
                    return rule
                end
                return bracket
            end

            local g_opts = {
                ignored_next_char = "[%w%.%\"%'%\\]",
                enable_check_bracket_line = false,
                fast_wrap = {
                    map = '<C-e>',
                    chars = { "{", "<", "[", "(", "\"", "'", "*", "$" },
                },
                enable_moveright = true,
                disable_in_visualblock = true,
            }

            local bracket = bracket_creator(g_opts)
            local quote = quote_creator(g_opts)

            npairs.setup(g_opts)
            -- latex
            npairs.add_rules({
                bracket("\\left[", "\\right]", { "tex", "latex", "markdown" }),
                bracket("\\left{", "\\right}", { "tex", "latex", "markdown" }),
                bracket("\\left(", "\\right)", { "tex", "latex", "markdown" }),
                -- bracket("\\frac{", "}{}", { "tex", "latex", "markdown" }),
                quote("$", "$", { "tex", "latex", "markdown" })
            })
            -- python
            npairs.add_rules({
                Rule("from argparse ", "", "python")
                    :with_cr(false)
                    :set_end_pair_length(0)
                    :replace_endpair(function(_) return "import ArgumentParser<Esc>o" end),
                Rule("import numpy ", "", "python")
                    :with_cr(false)
                    :set_end_pair_length(0)
                    :replace_endpair(function(_) return "as np<Esc>o" end),
                Rule("import matplotlib.pyplot ", "", "python")
                    :with_cr(false)
                    :set_end_pair_length(0)
                    :replace_endpair(function(_) return "as plt<Esc>o" end),
                Rule("import torch.nn ", "", "python")
                    :with_cr(false)
                    :set_end_pair_length(0)
                    :replace_endpair(function(_) return "as nn<Esc>o" end),
            })
            -- markdown, add latex rules to this as well
            npairs.add_rules({
                Rule("```", "```", "markdown"),
                quote("*", "*", "markdown"),
                quote("|", "|", "markdown"),
                Rule("\\begin{bmatrix}", "\\end{bmatrix", "markdown"),
                Rule("\\begin{equation}", "\\end{equation", "markdown"),
                Rule("\\begin{align}", "\\end{align", "markdown"),
                Rule("\\begin{equation*}", "\\end{equation*", "markdown"),
                Rule("\\begin{align*}", "\\end{align*", "markdown"),
            })
        end,
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        'windwp/nvim-ts-autotag',
        opts = { filetypes = { "html", "xml" } },
        ft = { "html", "xml" },
        event = "VeryLazy",
    },
    {
        'ibhagwan/fzf-lua',
        opts = {
            "telescope",
            winopts = {
                width = 0.95,
                height = 0.95,
                preview = {
                    border       = 'border', -- border|noborder, applies only to
                    wrap         = 'nowrap', -- wrap|nowrap
                    hidden       = 'nohidden', -- hidden|nohidden
                    vertical     = 'down:45%', -- up|down:size
                    horizontal   = 'right:60%', -- right|left:size
                    layout       = 'flex', -- horizontal|vertical|flex
                    flip_columns = 120, -- #cols to switch to horizontal on flex
                    title        = true, -- preview border title (file/buf)?
                    title_pos    = "center", -- left|center|right, title alignment
                    scrollbar    = 'float', -- `false` or string:'float|border'
                    scrolloff    = '-2', -- float scrollbar offset from right
                    scrollchars  = { '█', '' }, -- scrollbar chars ({ <full>, <empty> }
                    delay        = 100, -- delay(ms) displaying the preview
                    winopts      = { -- builtin previewer window options
                        number         = true,
                        relativenumber = false,
                        cursorline     = true,
                        cursorlineopt  = 'both',
                        signcolumn     = 'no',
                    },
                },
            },
        },
        event = "VeryLazy",
        cmd = "FzfLua",
        keys = {
            { '<C-p><C-p>',
                                function() return require("fzf-lua").files({
                        cmd = "find -type f | rg -v '.git/' | rg -v '.cache' | rg -v 'bin/' | rg -v 'logs/' " }) end },
            { '<C-p><C-f>', function() return require("fzf-lua").live_grep() end },
            { '#',          function() return require("fzf-lua").grep_cword() end },
            { '<C-p><C-d>', function() return require("fzf-lua").lsp_document_symbols() end },
            { '<C-p><C-b>', function() return require("fzf-lua").buffers() end },
            { '<C-p><C-h>', function()
                return require("fzf-lua").help_tags(
                    {
                        actions = {
                            ['ctrl-v'] = function(selected)
                                local last = selected[#selected]
                                local str = string.match(last, "%S+")
                                vim.cmd('help ' .. str)
                                vim.cmd('call feedkeys("\\<c-w>L")')
                            end
                        }
                    }
                )
            end },
            { '<C-p><C-q>',      function() return require("fzf-lua").blines() end },
            { '<C-p><C-i>',      function() return require("fzf-lua").lsp_workspace_symbols() end },
            { '<C-p><C-l>',      function() return require("fzf-lua").commands() end },
            { '<C-p><C-k>',      function() return require("fzf-lua").keymaps() end },
            { '<C-p><C-g><C-f>', function() return require("fzf-lua").git_files() end },
            { '<C-p><C-g><C-b>', function() return require("fzf-lua").git_branches() end },
            { '<C-p><C-g><C-l>', function() return require("fzf-lua").git_commits() end },

        }
    },
    'nvim-tree/nvim-web-devicons',
    {
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
        cmd = "Oil"
    },
    {
        'akinsho/toggleterm.nvim',
        config = function()
            require("toggleterm").setup {
                size = 40,
                open_mapping = [[<A-t>]],
                direction = 'float',
                shade_terminals = false,
                persist_size = false,
            }

            vim.api.nvim_create_augroup("TerminalKeymaps", { clear = true })
            vim.api.nvim_create_autocmd({ "TermOpen" }, {
                pattern = "term://*",
                callback = function()
                    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], { noremap = true })
                    vim.opt_local.number = false
                    vim.opt_local.relativenumber = false
                end
            })

            local Terminal = require('toggleterm.terminal').Terminal
            local pyterm = Terminal:new({ cmd = "/usr/bin/python", hidden = true })
            vim.keymap.set('n', [[<A-y>]], function() pyterm:toggle() end)
            vim.keymap.set('t', [[<A-y>]], function() pyterm:toggle() end)
        end,
        keys = {
            {"<A-t>"},
            {"<A-y>"},
        }
    },
    {
        'chrisgrieser/nvim-early-retirement',
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            retirementAgeMins = 10,
            ignoreVisibileBufs = false,
            notificationOnAutoClose = false,
        }
    },
    {
        'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        config = function()
            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (' 󰁂 %d '):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, 'MoreMsg' })
                return newVirtText
            end
            local ufo = require("ufo")
            ufo.setup({
                enable_get_fold_virt_text = true,
                fold_virt_text_handler = handler,
                provider_selector = function(_, _, _)
                    return { 'treesitter', 'indent' }
                end
            })
        end,
        keys = {
            { "zR", function() return require("ufo").openAllFolds() end,         desc = "open all folds" },
            { "zM", function() return require("ufo").closeAllFolds() end,        desc = "open all folds" },
            { "zr", function() return require("ufo").openFoldsExceptKinds() end, desc = "open all folds" },
            { "zm", function() return require("ufo").closeFoldsWith() end,     desc = "open all folds" },
        },
        event = "VeryLazy"
    },
    {
        'mbbill/undotree',
        config = function()
            vim.g.undotree_DiffpanelHeight = 17
            vim.g.undotree_WindowLayout = 2
            vim.g.undotree_SetFocusWhenToggle = 1
            vim.g.undotree_ShortIndicators = 1
            vim.g.undotree_DiffCommand = "git diff -p"
        end,
        cmd = "UndotreeToggle",
        keys = {
            { 'U', ':UndotreeToggle<CR>' }
        }
    },
    {
        'nguyenvukhang/nvim-toggler',
        opts = {
            inverses = {
                ['false'] = 'true',
                ['False'] = 'True',
                ['=='] = '!=',
            },
            remove_default_keybinds = true,
            remove_default_inverses = true,
        },
        keys = {
            { "gtt", function() return require("nvim-toggler").toggle() end},
        }
    },
}
return modules

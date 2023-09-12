return {
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
        -- -- python
        -- npairs.add_rules({
        --     Rule("from argparse ", "", "python")
        --         :with_cr(false)
        --         :set_end_pair_length(0)
        --         :replace_endpair(function(_) return "import ArgumentParser<Esc>o" end),
        --     Rule("import numpy ", "", "python")
        --         :with_cr(false)
        --         :set_end_pair_length(0)
        --         :replace_endpair(function(_) return "as np<Esc>o" end),
        --     Rule("import matplotlib.pyplot ", "", "python")
        --         :with_cr(false)
        --         :set_end_pair_length(0)
        --         :replace_endpair(function(_) return "as plt<Esc>o" end),
        --     Rule("import torch.nn ", "", "python")
        --         :with_cr(false)
        --         :set_end_pair_length(0)
        --         :replace_endpair(function(_) return "as nn<Esc>o" end),
        -- })
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
}

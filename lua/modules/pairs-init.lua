local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')
local cond = require('nvim-autopairs.conds')
-- local ts_conds = require('nvim-autopairs.ts-conds')

npairs.setup({
    ignored_next_char = "[%w%.%\"%']",
    enable_check_bracket_line = false,
    fast_wrap = {
        map = '<C-w>',
        chars = { "{", "<", "[", "(", "\"", "'"},
    }
})
npairs.add_rule(Rule("<", ">"))
-- latex
npairs.add_rules({
    Rule("\\left[", "\\right]", { "tex", "latex", "markdown" }),
    Rule("\\left{", "\\right}", { "tex", "latex", "markdown" }),
    Rule("\\left(", "\\right)", { "tex", "latex", "markdown" }),
    Rule("\\frac{", "}{}", { "tex", "latex", "markdown" }),
    Rule("$", "$", {"tex", "latex", "markdown"}),
})
-- python
npairs.add_rules({
    Rule("):", "return", "python")
    :end_wise(function(opts)
        return string.match(opts.line, "^%s*def")
    end),
    Rule("if __name__", " == \"__main__\":", "python")
    :with_cr(false)
    :set_end_pair_length(0),
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
    Rule("| ", " |", "markdown"),
    Rule("\\begin{bmatrix}", "\\end{bmatrix", "markdown"),
    Rule("\\begin{equation}", "\\end{equation", "markdown"),
    Rule("\\begin{align}", "\\end{align", "markdown"),
    Rule("\\begin{equation*}", "\\end{equation*", "markdown"),
    Rule("\\begin{align*}", "\\end{align*", "markdown"),
})

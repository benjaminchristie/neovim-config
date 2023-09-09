require("perfanno").setup {
    line_highlights = require("perfanno.util").make_bg_highlights("#1A1B26", "#CC3300", 10),
    vt_highlight = require("perfanno.util").make_fg_highlight("#CC3300"),
    annotate_after_load = true,
    annotate_on_open = true,
    ts_function_patterns = {
        default = {
            "function",
            "method",
        },
    },
}

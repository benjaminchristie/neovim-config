local null_ls = require("null-ls")
local gitsigns = null_ls.builtins.code_actions.gitsigns.with({
    config = {
        filter_actions = function(title)
            return title:lower():match("blame") == nil -- filter out blame actions
        end,
    },
})
local sources = {
    gitsigns,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.gofmt,
    -- null_ls.builtins.formatting.trim_whitespace,
    -- null_ls.builtins.formatting.trim_newlines,
    -- null_ls.builtins.formatting.autoflake,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.latexindent,
    null_ls.builtins.formatting.lua_format,
    -- null_ls.builtins.formatting.pyflyby,
}

null_ls.setup({
    sources = sources,
    debug = true,
    root_dir = require("lspconfig").util.root_pattern(
        ".git",
        "Makefile",
        "CMakeLists.txt"
    )
})

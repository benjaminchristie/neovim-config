require("nvim-surround").setup()
require("nvim-surround").buffer_setup {
    surrounds = {
        ["c"] = {
            add = function()
                local cmd = require("nvim-surround.config").get_input "Command: "
                return { { "\\" .. cmd .. "{" }, { "}" } }
            end,
        },
        ["e"] = {
            add = function()
                local env = require("nvim-surround.config").get_input "Environment: "
                return { { "\\begin{" .. env .. "}" }, { "\\end{" .. env .. "}" } }
            end,
        },
    },
}

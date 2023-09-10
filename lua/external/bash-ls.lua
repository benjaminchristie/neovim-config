return {
    "bash-lsp/bash-language-server",
    enabled = function()
        return vim.fn.executable("pnpm") and vim.fn.executable("npm")
    end,
    pin = false,
    build = table.concat({
            "pnpm install",
            "pnpm compile",
            "npm i -g --prefix ./bin ./server",
            "noglob echo \"" ..
            vim.fn.stdpath("data") ..
            "/lazy/bash-language-server/bin/bin/bash-language-server \"\\$@\"\" > $HOME/.local/bin/bash-language-server",
            "chmod +x $HOME/.local/bin/bash-language-server",
        },
        " && "
    )
}

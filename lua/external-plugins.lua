local modules = {
    -- externally managed plugins
    {
        'junegunn/fzf', build = "./install --all --no-fish", enabled = true, pin = true,
    },
    {
        'LuaLS/lua-language-server',
        commit = "d912dfc05636ca113eb074d637905f4b2514229d",
        build = table.concat({
                "./make.sh",
                "noglob echo \"" ..
                vim.fn.stdpath("data") ..
                "/lazy/lua-language-server/bin/lua-language-server \"\\$@\"\" > $HOME/.local/bin/lua-language-server",
                "chmod +x $HOME/.local/bin/lua-language-server"
            },
            " && "
        ),
        pin = true,
    },
    {
        "tomblind/local-lua-debugger-vscode",
        enabled = function()
            return vim.fn.executable("npm")
        end,
        pin = true,
        build = "npm install && npm run build",
    },
    {
        "bash-lsp/bash-language-server",
        enabled = function()
            return vim.fn.executable("pnpm") and vim.fn.executable("npm")
        end,
        pin = true,
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
    },
    {
        'artempyanykh/marksman',
        build = 'make install',
        enabled = function()
            return vim.fn.executable("dotnet")
        end,
        pin = true,
    },
    {
        'regen100/cmake-language-server',
        enabled = function()
            return vim.fn.executable("pip")
        end,
        build = vim.fn.stdpath("config") .. "/bin/pip-script.sh testresources cmake-language-server",
    },
    {
        'RobertCraigie/pyright-python',
        enabled = function()
            return vim.fn.executable("pip")
        end,
        build = vim.fn.stdpath("config") .. "/bin/pip-script.sh testresources pyright",
    },
    {
        'wbolster/black-macchiato',
        enabled = function()
            return vim.fn.executable("pip")
        end,
        build = vim.fn.stdpath("config") .. "/bin/pip-script.sh black-macchiato",
    },
    {
        'latex-lsp/texlab',
        enabled = function()
            return vim.fn.executable("cargo")
        end,
        build = "cargo build --release --color=never && cp ./target/release/texlab $HOME/.local/bin"
    },
}
return modules

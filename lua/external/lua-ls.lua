return {
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
}

vim.loader.enable()
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local function table_insert(t1, t2)
    for _, v in ipairs(t2) do
        table.insert(t1, v)
    end
    return t1
end

local spec = {}

spec = table_insert(spec, require("accessory-plugins"))
spec = table_insert(spec, require("cmp-plugins"))
spec = table_insert(spec, require("color-plugins"))
spec = table_insert(spec, require("dap-plugins"))
spec = table_insert(spec, require("external-plugins"))
spec = table_insert(spec, require("git-plugins"))
spec = table_insert(spec, require("lsp-plugins"))
spec = table_insert(spec, require("qol-plugins"))

require("lazy").setup(
    spec,
    {
        defaults = {
            lazy = true
        },
        install = {
            colorscheme = { "tokyonight-moon", "tokyonight", "default" }
        },
        diff = {
            cmd = "diffview.nvim",
        },
        dev = {
            path = vim.fn.stdpath("config") .. "/testing",
        },
        checker = { enabled = false }, -- automatically check for plugin updates
        performance = {
            rtp = {
                -- disable some rtp plugins
                disabled_plugins = {
                    -- "gzip",
                    -- "matchit",
                    -- "matchparen",
                    "netrwPlugin",
                    -- "tarPlugin",
                    -- "tohtml",
                    "tutor",
                    -- "zipPlugin",
                },
            },
        }
    }
)

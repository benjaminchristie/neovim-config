vim.loader.enable()
if vim.g.vscode ~= nil then
    vim.o.hlsearch = true
    vim.o.incsearch = true
    vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
    vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")
    vim.keymap.set('n', 'n', 'nzz')
    vim.keymap.set('n', 'N', 'Nzz')
    vim.keymap.set('n', '<C-d>', '<C-d>zz')
    vim.keymap.set('n', '<C-u>', '<C-u>zz')
    vim.keymap.set('n', '}', '}zz')
    vim.keymap.set('n', '{', '{zz')
    vim.keymap.set('n', '<Up>', '<C-b>')
    vim.keymap.set('n', '<Down>', '<C-f>')
    vim.keymap.set('n', '<Left>', 'gT')
    vim.keymap.set('n', '<Right>', 'gt')
    vim.o.loadplugins = false
end
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

local merge_tables = require("custom-utils").merge_tables

local spec = {}

spec = merge_tables(spec, require("accessory-plugins"))
spec = merge_tables(spec, require("cmp-plugins"))
spec = merge_tables(spec, require("color-plugins"))
spec = merge_tables(spec, require("dap-plugins"))
spec = merge_tables(spec, require("external-plugins"))
spec = merge_tables(spec, require("git-plugins"))
spec = merge_tables(spec, require("lsp-plugins"))
spec = merge_tables(spec, require("qol-plugins"))

require("lazy").setup(
    spec,
    {
        defaults = {
            lazy = true
        },
        install = {
            colorscheme = { "tokyonight-moon", "tokyonight", "tokyobones", "zenbones", "default" }
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

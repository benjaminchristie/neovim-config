local function statustool()
    if not pcall(function() vim.cmd('tab G') end) then
        vim.cmd('echohl WarningMsg | echo "Directory is not a git repository" | echohl None')
    end
end

local function difftool()
    local branch = vim.fn.input("Perform difftool on : ")
    vim.cmd("echon ' '")
    if not pcall(function() vim.cmd("DiffviewOpen " .. branch) end) then
        vim.cmd('echohl WarningMsg | echo "Directory is not a git repository" | echohl None')
    end
end

local function mergetool()
    vim.cmd("echon ' '")
    if not pcall(function() vim.cmd("Git mergetool -y ") end) then
        vim.cmd('echohl WarningMsg | echo "Directory is not a git repository" | echohl None')
    end
end

local extra_items = function()
    return function()
        return {
            { action = 'FzfLua live_grep', name = 'Grep',            section = 'Actions' },
            { action = 'FzfLua help_tags', name = 'Help',            section = 'Actions' },
            { action = 'FzfLua oldfiles',  name = 'History',         section = 'Actions' },
            { action = "FzfLua git_files", name = 'Workspace files', section = 'Actions' },
            { action = "FzfLua files",     name = 'All files',       section = 'Actions' },
            { action = difftool,           name = 'Diff tool',       section = 'Actions' },
            { action = mergetool,          name = 'Merge tool',      section = 'Actions' },
            { action = statustool,         name = 'Status',          section = 'Actions' },
        }
    end
end

local function ascii_headers(rand)
    local username = os.getenv("USER")
    username = string.gsub(username, "^%l", string.upper)
    return string.format([[
   .   ,- To the Moon %s !
  .'.            .       .
  |o|      .  *      .        .  *   .
 .'o'.       * .        .   *    ..
 |.-.|       .        .            *
 '   '     *      *        *    .
  ( )     .  *      .        .  *   .
   )    ..    *    .      *  .  ..  *
  ( )      *            .      *   *
    ]], username)
end

local ascii_art = ascii_headers()

local modules = {
    {
        'benjaminchristie/mini.starter',
        config = function()
            local starter_opts = {
                evaluate_single = false,
                header = ascii_art,
                items = {
                    require("mini.starter").sections.recent_files(7, false, true,
                        function(x) return vim.fn.pathshorten(x, 3) end),
                    extra_items(),
                },
                content_hooks = {
                    require("mini.starter").gen_hook.aligning("center", "center"),
                    require("mini.starter").gen_hook.padding(0, 0),
                },
                footer = "",
            }
            return require("mini.starter").setup(starter_opts)
        end,
        lazy = false,
        keys = {
            { '<A-s>', function() return require("mini.starter").open() end },
        }
    },
    {
        'benjaminchristie/nvim-colorizer.lua',
        cmd = "ColorizerToggle",
        event = "VeryLazy",
    },
    {
        'dstein64/vim-startuptime',
        lazy = true,
        enabled = false
    },
    {
        'p00f/godbolt.nvim',
        cmd = "Godbolt",
        event = "VeryLazy"
    },
    {
        'benjaminchristie/csgithub.nvim',
        event = "VeryLazy",
        keys = {
            { '<A-g>',
                function()
                    local csgithub = require("csgithub")
                    local url = csgithub.search({
                        includeFilename = false,
                        includeExtension = true,
                    })
                    if url == nil then
                        return
                    end
                    csgithub.open(url)
                end
            },
        },

    },

    {
        'tpope/vim-eunuch',
        event = "CmdlineEnter",
    },
    {
        'tpope/vim-repeat',
        event = "InsertEnter",
    },
    {
        'ThePrimeagen/harpoon',
        event = "VeryLazy",
        keys = {
            { "<A-0>", function() return require("harpoon.ui").nav_file(0) end },
            { "<A-1>", function() return require("harpoon.ui").nav_file(1) end },
            { "<A-2>", function() return require("harpoon.ui").nav_file(2) end },
            { "<A-3>", function() return require("harpoon.ui").nav_file(3) end },
            { "<A-4>", function() return require("harpoon.ui").nav_file(4) end },
            { "<A-5>", function() return require("harpoon.ui").nav_file(5) end },
            { "<A-6>", function() return require("harpoon.ui").nav_file(6) end },
            { "<A-7>", function() return require("harpoon.ui").nav_file(7) end },
            { "<A-8>", function() return require("harpoon.ui").nav_file(8) end },
            { "<A-9>", function() return require("harpoon.ui").nav_file(9) end },
            { "<A-h>", function() return require("harpoon.ui").toggle_quick_menu() end },
            { "<A-m>", function() return require("harpoon.mark").add_file() end },
            { "<A-k>", function() return require("harpoon.ui").nav_prev() end },
            { "<A-j>", function() return require("harpoon.ui").nav_next() end },
        }
    },
    { 'itchyny/vim-qfedit',     lazy = false },
    { 'kylechui/nvim-surround', lazy = false },
    { 'tpope/vim-commentary',   event = "BufEnter" },
    { 'tpope/vim-dispatch',     event = "BufEnter" },
    { 'tpope/vim-eunuch',       event = "BufEnter" },
    {
        'vladdoster/remember.nvim', event = "BufEnter"
    },
    {
        'dstein64/vim-startuptime',
        lazy = true,
        enabled = false
    },
    {
        'nacro90/numb.nvim',
        event = "CmdlineEnter",
        opts = {
            show_numbers = true,
            hide_relativenumbers = false,
        }
    },
    {
        'michaelb/sniprun',
        build = "sh install.sh",
        event = "VeryLazy",
        cmd = "SnipRun"
    },
    {
        't-troebst/perfanno.nvim',
        config = function() require("perfanno-init") end,
    },
    {
        'tzachar/local-highlight.nvim',
        opts = {
            disable_file_types = { 'tex' },
            hlgroup = 'LocalHighlight',
            cw_hlgroup = nil,
        },
        lazy = false,
        dependencies = { "folke/tokyonight.nvim" }
    },
}
return modules
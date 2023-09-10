local modules = {
    {
        'benjaminchristie/mini.starter',
        config = function()
            local function statustool()
                if not pcall(function() vim.cmd('tab G') end) then
                    vim.cmd('echohl WarningMsg | echo "Directory is not a git repository" | echohl None')
                end
            end

            local function diffviewopen()
                local branch = vim.fn.input("Perform difftool on : ")
                vim.cmd("echon ' '")
                if not pcall(function() vim.cmd("DiffviewOpen " .. branch) end) then
                    vim.cmd('echohl WarningMsg | echo "Directory is not a git repository" | echohl None')
                end
            end

            local function diffhistory()
                vim.cmd("echon ' '")
                if not pcall(function() vim.cmd("DiffviewFileHistory ") end) then
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
                        { action = diffviewopen,       name = 'Repo View',       section = 'Actions' },
                        { action = diffhistory,        name = 'Diff History',    section = 'Actions' },
                        { action = statustool,         name = 'Status',          section = 'Actions' },
                    }
                end
            end

            local function ascii_headers()
                local username = os.getenv("USER")
                if username == nil then username = "User" end
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
    { 'itchyny/vim-qfedit', lazy = false },
    {
        'kylechui/nvim-surround',
        config = function()
            require("nvim-surround").setup()
        end,
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        'tpope/vim-commentary',
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        'tpope/vim-dispatch',
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        'tpope/vim-eunuch',
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        'vladdoster/remember.nvim',
        lazy = false,
        config = function()
            require("remember").setup({
                open_folds = true
            })
        end
    },
    {
        'dstein64/vim-startuptime',
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
        cmd = "SnipRun"
    },
    {
        't-troebst/perfanno.nvim',
        config = function() require("perfanno-init") end,
        enabled = false,
    },
    {
        'tzachar/local-highlight.nvim',
        opts = {
            disable_file_types = { 'tex' },
            hlgroup = 'LocalHighlight',
            cw_hlgroup = nil,
        },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "folke/tokyonight.nvim" }
    },
    -- personal plugins:
    {
        dependencies = {
            'lewis6991/gitsigns.nvim',
            'nvim-treesitter/nvim-treesitter',
            'ThePrimeagen/harpoon',
        },
        config = function()
            require("statuswinbar").setup()
        end,
        dir = "statuswinbar",
        name = "statuswinbar",
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        name = "make-flow",
        dir = "make-flow",
        ft = "markdown",
    },
    {
        name = "custom-functions",
        config = function()
            require("custom-functions")
        end,
        dir = "custom-functions",
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        name = "custom-keymaps",
        config = function()
            require("custom-keymaps")
        end,
        dir = "custom-keymaps",
        event = { "BufReadPre", "BufNewFile" },

    }

}
return modules

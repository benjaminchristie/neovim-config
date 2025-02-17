return {
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
            autoopen = true,
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
    enabled = false,
    dev = false,
    -- keys = {
    --     { '<A-s>', function() return require("mini.starter").open() end },
    -- }
}

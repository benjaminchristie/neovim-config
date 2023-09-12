return {
    'ibhagwan/fzf-lua',
    dependencies = {
        'AckslD/swenv.nvim',
    },
    config = function()
        local opts = {
            "telescope",
            winopts = {
                width = 0.95,
                height = 0.95,
                preview = {
                    border       = 'border', -- border|noborder, applies only to
                    wrap         = 'nowrap', -- wrap|nowrap
                    hidden       = 'nohidden', -- hidden|nohidden
                    vertical     = 'down:45%', -- up|down:size
                    horizontal   = 'right:60%', -- right|left:size
                    layout       = 'flex', -- horizontal|vertical|flex
                    flip_columns = 120, -- #cols to switch to horizontal on flex
                    title        = true, -- preview border title (file/buf)?
                    title_pos    = "center", -- left|center|right, title alignment
                    scrollbar    = 'float', -- `false` or string:'float|border'
                    scrolloff    = '-2', -- float scrollbar offset from right
                    scrollchars  = { '█', '' }, -- scrollbar chars ({ <full>, <empty> }
                    delay        = 100, -- delay(ms) displaying the preview
                    winopts      = { -- builtin previewer window options
                        number         = true,
                        relativenumber = false,
                        cursorline     = true,
                        cursorlineopt  = 'both',
                        signcolumn     = 'no',
                    },
                },
            },
        }
        require("fzf-lua").setup(opts)
        require("fzf-lua").register_ui_select()
    end,
    event = "VeryLazy",
    cmd = "FzfLua",
    keys = {
        { '<C-p><C-p>',
            function()
                return require("fzf-lua").files({
                    cmd = "find -type f | rg -v '.git/' | rg -v '.cache' | rg -v 'bin/' | rg -v 'logs/' " })
            end },
        { '<C-p><C-f>', function() return require("fzf-lua").live_grep() end },
        { '#',          function() return require("fzf-lua").grep_cword() end },
        { '<C-p><C-d>', function() return require("fzf-lua").lsp_document_symbols() end },
        { '<C-p><C-b>', function() return require("fzf-lua").buffers() end },
        { '<C-p><C-h>', function()
            return require("fzf-lua").help_tags(
                {
                    actions = {
                        ['ctrl-v'] = function(selected)
                            local last = selected[#selected]
                            local str = string.match(last, "%S+")
                            vim.cmd('help ' .. str)
                            vim.cmd('call feedkeys("\\<c-w>L")')
                        end
                    }
                }
            )
        end },
        { '<C-p><C-q>',      function() return require("fzf-lua").blines({ start = "cursor" }) end },
        { '<C-p><C-i>',      function() return require("fzf-lua").lsp_workspace_symbols() end },
        { '<C-p><C-l>',      function() return require("fzf-lua").commands() end },
        { '<C-p><C-k>',      function() return require("fzf-lua").keymaps() end },
        { '<C-p><C-g><C-f>', function() return require("fzf-lua").git_files() end },
        { '<C-p><C-g><C-b>', function() return require("fzf-lua").git_branches() end },
        { '<C-p><C-g><C-l>', function() return require("fzf-lua").git_commits() end },
        { '<C-p><C-o>',      function() return require("fzf-lua").oldfiles() end },
        { '<C-p><C-y>',      function() return vim.cmd("PyenvActivate") end },
        { '<C-p><C-s>',      function() return require("custom-functions").skeletons() end },

    }
}

local fzf = require("fzf-lua")
fzf.setup({
    "telescope",
    winopts = {
        width = 0.95,
        height = 0.95,
        preview = {
          border         = 'border',        -- border|noborder, applies only to
          wrap           = 'nowrap',        -- wrap|nowrap
          hidden         = 'nohidden',      -- hidden|nohidden
          vertical       = 'down:45%',      -- up|down:size
          horizontal     = 'right:60%',     -- right|left:size
          layout         = 'flex',          -- horizontal|vertical|flex
          flip_columns   = 120,             -- #cols to switch to horizontal on flex
          title          = true,            -- preview border title (file/buf)?
          title_pos      = "center",        -- left|center|right, title alignment
          scrollbar      = 'float',         -- `false` or string:'float|border'
          scrolloff      = '-2',            -- float scrollbar offset from right
          scrollchars    = {'█', '' },      -- scrollbar chars ({ <full>, <empty> }
          delay          = 100,             -- delay(ms) displaying the preview
          winopts = {                       -- builtin previewer window options
            number            = true,
            relativenumber    = false,
            cursorline        = true,
            cursorlineopt     = 'both',
            signcolumn        = 'no',
          },
        },
    },
})

vim.keymap.set('n', '<C-p><C-p>', function() return fzf.files({cmd = "find -type f | rg -v '.git' | rg -v '.cache' | rg -v 'bin/' | rg -v 'logs/' "}) end )
vim.keymap.set('n', '<C-p><C-f>', function() return fzf.live_grep() end)
vim.keymap.set('n', '#',          function() return fzf.grep_cword() end)
vim.keymap.set('n', '<C-p><C-d>', function() return fzf.lsp_document_symbols() end)
vim.keymap.set('n', '<C-p><C-b>', function() return fzf.buffers() end)
vim.keymap.set('n', '<C-p><C-h>', function() return fzf.help_tags() end)
-- vim.keymap.set('n', '<C-p><C-c>', function() return builtins.git_bcommits() end)
vim.keymap.set('n', '<C-p><C-q>', function() return fzf.blines() end)
vim.keymap.set('n', '<C-p><C-i>', function() return fzf.lsp_workspace_symbols() end)
vim.keymap.set('n', '<C-p><C-l>', function() return fzf.commands() end)
vim.keymap.set('n', '<C-p><C-g><C-f>', function() return fzf.git_files() end)
vim.keymap.set('n', '<C-p><C-g><C-b>', function() return fzf.git_branches() end)
vim.keymap.set('n', '<C-p><C-g><C-l>', function() return fzf.git_commits()  end)

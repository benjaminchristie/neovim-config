local gitsigns = require("gitsigns")
local dap = require("dap")
local dapui = require("dapui")

vim.keymap.set('n', '<Left>', 'gT')
vim.keymap.set('n', '<Right>', 'gt')
vim.keymap.set('i', '<Left>', '<Esc>gT')
vim.keymap.set('i', '<Right>', '<Esc>gt')
vim.keymap.set('n', '`1', ':5winc<<CR>')
vim.keymap.set('n', '`4', ':5winc><CR>')
vim.keymap.set('n', '`2', ':3winc+<CR>')
vim.keymap.set('n', '`3', ':3winc-<CR>')
vim.keymap.set('n', 'zs', 'zMzO')
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '}', '}zz')
vim.keymap.set('n', '{', '{zz')
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<C-h><C-q>', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<C-k>', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<C-j>', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', 'gh', vim.diagnostic.setloclist, opts)
--- DAP
vim.keymap.set('n', '<A-d><A-r>', dap.restart)
vim.keymap.set('n', '<A-d><A-d>', dap.continue)
vim.keymap.set('n', '<A-d><A-q>', function ()
    dap.close()
    dapui.close()
end)
vim.keymap.set('n', '<A-d><A-l>', dap.list_breakpoints)
vim.keymap.set('n', '<A-d><A-b>', dap.toggle_breakpoint)
vim.keymap.set('n', '<A-d><A-p>', dap.pause)
vim.keymap.set('n', '<A-d><A-n>', dap.step_over)
vim.keymap.set('n', '<A-d><A-s>', dap.step_into)

local search_github = function ()
    local csgithub = require("csgithub")
    local url = csgithub.search({
	includeFilename=false,
	includeExtension=true,
    })
    if url == nil then
    	return
    end
    csgithub.open(url)
end
vim.keymap.set('n', '<A-g>', function() return search_github() end)
vim.keymap.set('v', '<A-g>', function() return search_github() end)
-- commentary improvements
vim.keymap.set('n', 'gcc', function ()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local col_count_pre = vim.fn.strlen(vim.api.nvim_get_current_line())
    vim.cmd("Commentary")
    local col_count_post = vim.fn.strlen(vim.api.nvim_get_current_line())
    local offset = col_count_post - col_count_pre
    cursor_pos[2] = cursor_pos[2] + offset
    vim.api.nvim_win_set_cursor(0, cursor_pos)
end)
-- git stuff
vim.keymap.set('n', 'gM', ':Git mergetool -y ')
vim.keymap.set('n', 'gV', ':Git difftool -y ')
vim.keymap.set('n', 'gR', ':Git rebase --interactive -i HEAD~')

IsGitsignsToggled = false
vim.keymap.set('n', 'gst', function()
    IsGitSignsToggled = not IsGitSignsToggled
    gitsigns.toggle_current_line_blame(IsGitSignsToggled)
    gitsigns.toggle_linehl(IsGitSignsToggled)
    gitsigns.toggle_deleted(IsGitSignsToggled)
    gitsigns.toggle_numhl(IsGitSignsToggled)
end)

vim.keymap.set('n', 'gss', gitsigns.stage_hunk)
-- equivalent to Gwrite
vim.keymap.set('n', 'gsa', gitsigns.stage_buffer)
-- equivalent to Gread
vim.keymap.set('n', 'gsr', gitsigns.reset_buffer)

-- cd to current working file
vim.keymap.set('n', '<A-c>', function ()
    local cwd = vim.fn.expand("%:p:h")
    vim.api.nvim_set_current_dir(cwd)
    print("Changed cwd to " .. cwd)
end)

-- find and replace assistance
vim.keymap.set('n', '\\s', function ()
    local word = vim.fn.expand("<cword>")
    local line_num = vim.api.nvim_win_get_cursor(0)[1]
    local change_to = vim.fn.input("Change " .. word .. " to : ")
    vim.cmd(':%s/' .. word .. "/" .. change_to .. "/g")
    vim.cmd(":" .. line_num)
    end
)

local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ('  %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, 'MoreMsg'})
    return newVirtText
end
local ufo = require("ufo")
ufo.setup({
    enable_get_fold_virt_text = true,
    fold_virt_text_handler = handler,
    provider_selector = function(_, _, _)
        return {'treesitter', 'indent'}
    end
})
vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)
vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds)
vim.keymap.set('n', 'zm', ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set('n', 'K', function()
    local winid = ufo.peekFoldedLinesUnderCursor()
    if not winid then
        vim.lsp.buf.hover()
    end
end)


-- handle harpoon
for i = 0, 9, 1 do
   vim.keymap.set('n', '<A-'..i..">", function() return require("harpoon.ui").nav_file(i) end)
end
vim.keymap.set('n', "<A-h>", function() return require("harpoon.ui").toggle_quick_menu() end)
vim.keymap.set('n', "<A-m>", function() return require("harpoon.mark").add_file() end)
vim.keymap.set('n', "<A-k>", function() return require("harpoon.ui").nav_prev() end)
vim.keymap.set('n', "<A-j>", function() return require("harpoon.ui").nav_next() end)


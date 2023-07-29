local gitsigns = require("gitsigns")

vim.keymap.set('n', '<Up>', '<C-b>')
vim.keymap.set('n', '<Down>', '<C-f>')
vim.keymap.set('n', '<Left>', 'gT')
vim.keymap.set('n', '<Right>', 'gt')
vim.keymap.set('i', '<Up>', '<Esc><C-b>')
vim.keymap.set('i', '<Down>', '<Esc><C-f>')
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
-- git stuff
vim.keymap.set('n', 'gM', ':Git mergetool -y ')
vim.keymap.set('n', 'gV', ':Git difftool -y ')
vim.keymap.set('n', 'gR', ':Git rebase --interactive -i HEAD~')
vim.keymap.set('n', 'gst', function()
    gitsigns.toggle_current_line_blame(true)
    gitsigns.toggle_linehl(true)
    gitsigns.toggle_deleted(true)
    gitsigns.toggle_numhl(true)
end)
vim.keymap.set('n', 'gsf', function()
    gitsigns.toggle_current_line_blame(false)
    gitsigns.toggle_linehl(false)
    gitsigns.toggle_deleted(false)
    gitsigns.toggle_numhl(false)
end)

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
require('ufo').setup({
    enable_get_fold_virt_text = true,
    fold_virt_text_handler = handler,
    provider_selector = function(_, _, _)
        return {'treesitter', 'indent'}
    end
})
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set('n', 'K', function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
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


local gitsigns = require("gitsigns")
local perfanno = require("perfanno")
local util = require("perfanno.util")
--- set keymappings --- 
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

-- vim.keymap.set('n', '<C-l><C-d>', ':ClangFormat<CR>')

--- cool block commands
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

-- ufo

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


-- perfanno 

perfanno.setup {
    line_highlights = util.make_bg_highlights("#1A1B26", "#CC3300", 10),
    vt_highlight = util.make_fg_highlight("#CC3300"),
    annotate_after_load = true,
    annotate_on_open = true,
    ts_function_patterns = {
        default = {
            "function",
            "method",
        },
    },
}

-- ROS config 
-- Where am i config
local function whereami()
    local uptime = 7
    local downtime = 3
    local cursor_colors = {
        "#24283b", "#262b40", "#282d45", "#2a304a", "#2c324f", "#2e3554", "#303759", "#32395e", "#333c64", "#353e69",
        "#36406e", "#384274", "#39457a", "#3a477f", "#3c4985", "#3d4b8b", "#3e4d91", "#3f4f97", "#40519d", "#4152a3",
        "#4254a9", "#4256af", "#4358b5", "#445abb", "#485dbf", "#4c61c2", "#5065c4", "#5469c7", "#586dca", "#5d71cd",
        "#6175d0", "#6579d2", "#6a7dd5", "#6e82d7", "#7386d9", "#778adc", "#7c8ede", "#8193e0", "#8697e2", "#8b9be4",
        "#90a0e6", "#95a4e8", "#9aa9ea", "#9faeec", "#a5b2ee", "#aab7ef", "#afbcf1", "#b5c0f2", "#bac5f4", "#c0caf5"
    }
    local length = #cursor_colors
    for i = 0, length, 1 do
        vim.fn.timer_start((i + 1) * uptime, function ()
            vim.wo.cursorline = true
            vim.wo.cursorcolumn = true
            vim.api.nvim_set_hl(1, "Cursor",       {bg=cursor_colors[i]})
            vim.api.nvim_set_hl(1, "CursorLine",   {bg=cursor_colors[i]})
            vim.api.nvim_set_hl(1, "CursorColumn", {bg=cursor_colors[i]})
            vim.api.nvim_win_set_hl_ns(vim.api.nvim_get_current_win(), 1)
        end)
        vim.fn.timer_start((length) * uptime + (i + 1) * downtime, function ()
            vim.wo.cursorline = true
            vim.wo.cursorcolumn = true
            vim.api.nvim_set_hl(1, "Cursor",       {bg=cursor_colors[length - i - 1]})
            vim.api.nvim_set_hl(1, "CursorLine",   {bg=cursor_colors[length - i - 1]})
            vim.api.nvim_set_hl(1, "CursorColumn", {bg=cursor_colors[length - i - 1]})
            vim.api.nvim_win_set_hl_ns(vim.api.nvim_get_current_win(), 1)
        end)
        vim.fn.timer_start((length + 1) * (uptime + downtime), function ()
            vim.wo.cursorcolumn = false
            vim.o.cursorcolumn = false
            vim.api.nvim_win_set_hl_ns(vim.api.nvim_get_current_win(), 0)
        end)
    end
end
vim.api.nvim_create_user_command("Where", whereami, {})

vim.api.nvim_create_user_command("TmpLua", function ()
    vim.cmd("e /tmp/tmp" .. vim.fn.reltimestr(vim.fn.reltime()))
    vim.bo.filetype = "lua"
end, {})

vim.api.nvim_create_user_command("Ex", function ()
    local HEIGHT = 12
    vim.cmd("topleft Oil")
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.api.nvim_win_set_height(0, HEIGHT)
end, {})
vim.api.nvim_create_user_command("Lex", function ()
    local WIDTH = 45
    vim.cmd("vertical Oil")
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.api.nvim_win_set_width(0, WIDTH)
end, {})

vim.api.nvim_create_augroup("LaunchEnterGroup", {clear = false})
vim.api.nvim_create_autocmd({"BufEnter"}, {
    group = "LaunchEnterGroup",
    pattern = {"*.launch", ".urdf", "*.xacro", "*.xml"},
    callback = function()
        vim.opt_local.filetype = "html"
    end
})
vim.api.nvim_create_augroup("ClangFormatGroup", {clear = false})
vim.api.nvim_create_autocmd({"BufWritePre"}, {
    group = "ClangFormatGroup",
    pattern = {"*.cpp", "*.h", "*.hpp", "*.c"},
    callback = function()
        vim.cmd("ClangFormat")
    end
})

vim.keymap.set('n', '<Left>', 'gT', { desc = "Go to left tab" })
vim.keymap.set('n', '<Right>', 'gt', { desc = "Go to right tab" })
vim.keymap.set('i', '<Left>', '<Esc>gT', { desc = "Go to left tab" })
vim.keymap.set('i', '<Right>', '<Esc>gt', { desc = "Go to right tab" })
vim.keymap.set('n', '`1', ':5winc<<CR>', { desc = "Change window size" })
vim.keymap.set('n', '`4', ':5winc><CR>', { desc = "Change window size" })
vim.keymap.set('n', '`2', ':3winc+<CR>', { desc = "Change window size" })
vim.keymap.set('n', '`3', ':3winc-<CR>', { desc = "Change window size" })
vim.keymap.set('n', 'zs', 'zMzO', { desc = "Open all folds" })
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv", { desc = "Move text as block" })
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv", { desc = "Move text as block" })
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '}', '}zz')
vim.keymap.set('n', '{', '{zz')
vim.keymap.set('n', "<A-p>", ":cprev<CR>")
vim.keymap.set('n', "<A-n>", ":cnext<CR>")

local timers = {}
local search_timer_timeout = 20000
local search_timer_iter = 50
local bg_highlight = "#3E68D7"
local bg_highlight_vals = { '#3B62C8', '#395CBA', '#3655AB', '#344F9C', '#31498E', '#2F437F', '#2C3D71', '#2A3762',
    '#273053', '#252A45', '#222436' }
local function timed_color_change()
    for _, t in ipairs(timers) do
        vim.fn.timer_stop(t)
    end
    timers = {}
    local search_timer = vim.fn.timer_start(search_timer_timeout, function()
        for i = 1, #bg_highlight_vals, 1 do
            local timer = vim.fn.timer_start(i * search_timer_iter, function()
                vim.api.nvim_set_hl(0, "IncSearch", { bg = bg_highlight_vals[i] })
                vim.api.nvim_set_hl(0, "Search", { bg = bg_highlight_vals[i] })
            end)
            table.insert(timers, timer)
        end
        local timer = vim.fn.timer_start((#bg_highlight_vals + 1) * search_timer_iter + search_timer_iter, function()
            vim.cmd("nohl")
        end)
        table.insert(timers, timer)
    end)
    table.insert(timers, search_timer)
end
vim.keymap.set('n', 'n', function()
        vim.api.nvim_set_hl(0, "IncSearch", { bg = bg_highlight })
        vim.api.nvim_set_hl(0, "Search", { bg = bg_highlight })
        vim.fn.feedkeys('nzz', "n")
        timed_color_change()
    end,
    { noremap = true })
vim.keymap.set('n', 'N', function()
        vim.api.nvim_set_hl(0, "IncSearch", { bg = bg_highlight })
        vim.api.nvim_set_hl(0, "Search", { bg = bg_highlight })
        vim.fn.feedkeys('Nzz', "n")
        timed_color_change()
    end,
    { noremap = true })

vim.keymap.set('n', '<A-s>', require("mini.starter").open, { desc = "open mini.starter screen" })
vim.keymap.set({'n', 'v'}, 'gtt', require('nvim-toggler').toggle)
--- DAP
vim.keymap.set('n', '<A-d><A-v>', function()
    vim.cmd("DapVirtualTextEnable")
end, { desc = "enable virtual text when debugging" })
vim.keymap.set('n', '<A-d><A-r>', require("dap").restart, { desc = "restart debugger" })
vim.keymap.set('n', '<A-d><A-t>', require("dap").run_to_cursor, { desc = "run to cursor" })
vim.keymap.set('n', '<A-d><A-d>', require("dap").continue, { desc = "continue debugger" })
vim.keymap.set('n', '<A-d><A-q>', function()
    require("dap").close()
    require("dapui").close()
end)
vim.keymap.set('n', '<A-d><A-l>', function()
    require("dap").toggle_breakpoint(nil, nil, vim.fn.input("Log : "))
end)
vim.keymap.set('n', '<A-d><A-b>', function()
     require('persistent-breakpoints.api').toggle_breakpoint(vim.fn.input("Condition : "))
end)
vim.keymap.set('n', '<A-d><A-p>', function()
    require("dapui").eval(nil, {
        enter = true
    })
end)
vim.keymap.set('n', '<A-d><A-n>', require("dap").step_over, { desc = "step over function" })
vim.keymap.set('n', '<A-d><A-s>', require("dap").step_into, { desc = "step into function" })

local search_github = function()
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
vim.keymap.set('n', '<A-g>', function() return search_github() end)
vim.keymap.set('v', '<A-g>', function() return search_github() end)
-- commentary improvements
vim.keymap.set('n', '<C-_>', function()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local col_count_pre = vim.fn.strlen(vim.api.nvim_get_current_line())
    vim.cmd("Commentary")
    local col_count_post = vim.fn.strlen(vim.api.nvim_get_current_line())
    local offset = col_count_post - col_count_pre
    cursor_pos[2] = cursor_pos[2] + offset
    vim.api.nvim_win_set_cursor(0, cursor_pos)
end, { desc = "toggle comment while preserving place on line" })
-- git stuff
vim.keymap.set('n', 'gM', ':Git mergetool ')
vim.keymap.set('n', 'gV', ':Git difftool -y ')
vim.keymap.set('n', 'gR', ':Git rebase --interactive -i HEAD~')
vim.keymap.set('n', 'gC', ':Git rebase --continue<CR>')
vim.keymap.set('n', 'gP', ':Git checkout --patch <branch> <filename>') --- TODO: make this better
vim.keymap.set('n', 'dl', ':diffget //3<CR>')
vim.keymap.set('n', 'dh', ':diffget //2<CR>')
vim.keymap.set('n', 'gD', ':Gvdiffsplit!<CR>')

local is_gitsigns_toggled = false
vim.keymap.set('n', 'gst', function()
    is_gitsigns_toggled = not is_gitsigns_toggled
    require("gitsigns").toggle_current_line_blame(is_gitsigns_toggled)
    require("gitsigns").toggle_linehl(is_gitsigns_toggled)
    require("gitsigns").toggle_deleted(is_gitsigns_toggled)
    require("gitsigns").toggle_numhl(is_gitsigns_toggled)
end, { desc = "toggle gitsigns blame and buffer changes" })

vim.keymap.set('n', 'gss', require("gitsigns").stage_hunk, { desc = "gitsigns stage hunk" })
-- equivalent to Gwrite
vim.keymap.set('n', 'gsa', require("gitsigns").stage_buffer, { desc = "gitsigns stage buffer" })
-- equivalent to Gread
vim.keymap.set('n', 'gsr', require("gitsigns").reset_hunk, { desc = "gitsigns reset hunk" })
-- toggle file history
vim.keymap.set('n', 'gsov', ':DiffviewFileHistory<CR>')
vim.keymap.set('n', 'gsoo', ':DiffviewFileHistory<CR>')
vim.keymap.set('n', 'gsoc', ':DiffviewFileHistory %<CR>')

-- cd to current working file
vim.keymap.set('n', '<A-c>', function()
    local cwd = vim.fn.expand("%:p:h")
    vim.api.nvim_set_current_dir(cwd)
    print("Changed cwd to " .. cwd)
end)

-- find and replace assistance
vim.keymap.set('n', '\\s', function()
    local word = vim.fn.expand("<cword>")
    local line_num = vim.api.nvim_win_get_cursor(0)[1]
    local change_to = vim.fn.input("Change " .. word .. " to : ")
    vim.cmd(':%s/' .. word .. "/" .. change_to .. "/g")
    vim.cmd(":" .. line_num)
end, { desc = "find and replace across scope and file" })

local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰁂 %d '):format(endLnum - lnum)
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
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
end
local ufo = require("ufo")
ufo.setup({
    enable_get_fold_virt_text = true,
    fold_virt_text_handler = handler,
    provider_selector = function(_, _, _)
        return { 'treesitter', 'indent' }
    end
})
vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = "open all folds" })
vim.keymap.set('n', 'zM', ufo.closeAllFolds, { desc = "close all folds" })
vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds, { desc = "open most folds" })
vim.keymap.set('n', 'zm', ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set('n', 'K', function()
    local winid = ufo.peekFoldedLinesUnderCursor()
    if not winid then
        vim.lsp.buf.hover()
    end
end, { desc = "peek fold, or call lsp.buf.hover()" })


-- handle harpoon
for i = 0, 9, 1 do
    vim.keymap.set('n', '<A-' .. i .. ">", function() return require("harpoon.ui").nav_file(i) end)
end
vim.keymap.set('n', "<A-h>", function() return require("harpoon.ui").toggle_quick_menu() end)
vim.keymap.set('n', "<A-m>", function() return require("harpoon.mark").add_file() end)
vim.keymap.set('n', "<A-k>", function() return require("harpoon.ui").nav_prev() end)
vim.keymap.set('n', "<A-j>", function() return require("harpoon.ui").nav_next() end)



local function on_demand_autogroup()
    vim.fn.feedkeys(
    ":lua vim.api.nvim_create_autocmd({\"BufWrite\"}, {pattern=vim.api.nvim_buf_get_name(0), callback = function() <todo> end})")
end

vim.keymap.set('n', "<A-e>", on_demand_autogroup)

vim.keymap.set('n', '<C-p><C-p>', function() return require("fzf-lua").files({ cmd = "find -type f | rg -v '.git' | rg -v '.cache' | rg -v 'bin/' | rg -v 'logs/' " }) end)
vim.keymap.set('n', '<C-p><C-f>', function() return require("fzf-lua").live_grep() end)
vim.keymap.set('n', '#', function() return require("fzf-lua").grep_cword() end)
vim.keymap.set('n', '<C-p><C-d>', function() return require("fzf-lua").lsp_document_symbols() end)
vim.keymap.set('n', '<C-p><C-b>', function() return require("fzf-lua").buffers() end)
vim.keymap.set('n', '<C-p><C-h>', function() return require("fzf-lua").help_tags(help_opts) end)
-- vim.keymap.set('n', '<C-p><C-c>', function() return builtins.git_bcommits() end)
vim.keymap.set('n', '<C-p><C-q>', function() return require("fzf-lua").blines() end)
vim.keymap.set('n', '<C-p><C-i>', function() return require("fzf-lua").lsp_workspace_symbols() end)
vim.keymap.set('n', '<C-p><C-l>', function() return require("fzf-lua").commands() end)
vim.keymap.set('n', '<C-p><C-k>', function() return require("fzf-lua").keymaps() end)
vim.keymap.set('n', '<C-p><C-g><C-f>', function() return require("fzf-lua").git_files() end)
vim.keymap.set('n', '<C-p><C-g><C-b>', function() return require("fzf-lua").git_branches() end)
vim.keymap.set('n', '<C-p><C-g><C-l>', function() return require("fzf-lua").git_commits() end)


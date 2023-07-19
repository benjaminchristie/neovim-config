--- set keymappings --- 
vim.keymap.set('n', '<Up>', '<C-b>')
vim.keymap.set('n', '<Down>', '<C-f>')
vim.keymap.set('n', '<Left>', 'gT')
vim.keymap.set('n', '<Right>', 'gt')

vim.keymap.set('n', '`1', ':5winc<<CR>')
vim.keymap.set('n', '`4', ':5winc><CR>')
vim.keymap.set('n', '`2', ':3winc+<CR>')
vim.keymap.set('n', '`3', ':3winc-<CR>')
vim.keymap.set('n', 'zs', 'zMzO')

--- cool block commands
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '}', '}zz')
vim.keymap.set('n', '{', '{zz')


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

-- handle harpoon
for i = 0, 9, 1 do
   vim.keymap.set('n', '<A-'..i..">", function() return require("harpoon.ui").nav_file(i) end)
end
vim.keymap.set('n', "<A-h>", function() return require("harpoon.ui").toggle_quick_menu() end)
vim.keymap.set('n', "<A-m>", function() return require("harpoon.mark").add_file() end)
vim.keymap.set('n', "<A-k>", function() return require("harpoon.ui").nav_prev() end)
vim.keymap.set('n', "<A-j>", function() return require("harpoon.ui").nav_next() end)


-- perfanno 
local perfanno = require("perfanno")
local util = require("perfanno.util")

perfanno.setup {
    -- Creates 10-step color gradient between pure black (#000000) and #CC3300
    line_highlights = util.make_bg_highlights("#1A1B26", "#CC3300", 10),
    vt_highlight = util.make_fg_highlight("#CC3300"),
    annotate_after_load = true,
    annotate_on_open = true,
    ts_function_patterns = {
        -- These should work for most languages (at least those used with perf)
        default = {
            "function",
            "method",
        },
    },
}

-- ROS config 
vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern = {"*.launch", ".urdf", "*.xacro"},
    callback = function()
        vim.opt_local.filetype = "html"
    end
})

-- user commands
-- Gitsigns config
local gitsigns = require("gitsigns")
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
-- Where am i config
local function whereami()
    local uptime = 7
    local downtime = 3
    local cursor_colors = {
         "#24283b",  "#262b40",  "#282d45",  "#2a304a",  "#2c324f",  "#2e3554",  "#303759",  "#32395e",  "#333c64",
 "#353e69",  "#36406e",  "#384274",  "#39457a",  "#3a477f",  "#3c4985",  "#3d4b8b",  "#3e4d91",  "#3f4f97",
 "#40519d",  "#4152a3",  "#4254a9",  "#4256af",  "#4358b5",  "#445abb",  "#485dbf",  "#4c61c2",  "#5065c4", "#5469c7",  "#586dca",  "#5d71cd",  "#6175d0",  "#6579d2",  "#6a7dd5",  "#6e82d7",  "#7386d9",  "#778adc", "#7c8ede",  "#8193e0",  "#8697e2",  "#8b9be4",  "#90a0e6",  "#95a4e8",  "#9aa9ea",  "#9faeec",  "#a5b2ee", "#aab7ef",  "#afbcf1",  "#b5c0f2",  "#bac5f4",  "#c0caf5"
    }
    local length = #cursor_colors
    for i = 0, length, 1 do
        vim.fn.timer_start((i + 1) * uptime, function ()
            vim.wo.cursorline = true
            vim.wo.cursorcolumn = true
            vim.api.nvim_set_hl(1, "CursorLine", {bg=cursor_colors[i]})
            vim.api.nvim_set_hl(1, "CursorColumn", {bg=cursor_colors[i]})
            vim.api.nvim_win_set_hl_ns(vim.api.nvim_get_current_win(), 1)
        end)
        vim.fn.timer_start((length) * uptime + (i + 1) * downtime, function ()
            vim.wo.cursorline = true
            vim.wo.cursorcolumn = true
            vim.api.nvim_set_hl(1, "CursorLine", {bg=cursor_colors[length - i - 1]})
            vim.api.nvim_set_hl(1, "CursorColumn", {bg=cursor_colors[length - i - 1]})
            vim.api.nvim_win_set_hl_ns(vim.api.nvim_get_current_win(), 1)
        end)
        vim.fn.timer_start((length + 1) * (uptime + downtime), function ()
            vim.wo.cursorcolumn = false
            vim.o.cursorcolumn = false
        end)
    end
    vim.api.nvim_win_set_hl_ns(vim.api.nvim_get_current_win(), 0)
end
vim.api.nvim_create_user_command("Where", whereami, {})
vim.api.nvim_create_user_command("Lex", "NvimTreeFindFile", {})
vim.api.nvim_create_user_command("Ex", "NvimTreeFocus", {})

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
-- fugitive stuff
vim.keymap.set('n', 'gM', ':Git mergetool -y ')
vim.keymap.set('n', 'gV', ':Git difftool -y ')
vim.keymap.set('n', 'gR', ':Git rebase --interactive -i HEAD~')
vim.g.editorconfig_trim_trailing_whitespace = true

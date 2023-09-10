vim.keymap.set('n', '<Left>', 'gT', { desc = "Go to left tab" })
vim.keymap.set('n', '<Right>', 'gt', { desc = "Go to right tab" })
vim.keymap.set('i', '<Left>', '<Esc>gT', { desc = "Go to left tab" })
vim.keymap.set('i', '<Right>', '<Esc>gt', { desc = "Go to right tab" })
vim.keymap.set('n', '`1', ':5winc<<CR>', { desc = "Change window size" })
vim.keymap.set('n', '`4', ':5winc><CR>', { desc = "Change window size" })
vim.keymap.set('n', '`2', ':3winc+<CR>', { desc = "Change window size" })
vim.keymap.set('n', '`3', ':3winc-<CR>', { desc = "Change window size" })
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv", { desc = "Move text as block" })
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv", { desc = "Move text as block" })
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

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

vim.keymap.set('n', "<A-p>", ":cprev<CR>")
vim.keymap.set('n', "<A-n>", ":cnext<CR>")

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



local function on_demand_autogroup()
    vim.fn.feedkeys(
    ":lua vim.api.nvim_create_autocmd({\"BufWrite\"}, {pattern=vim.api.nvim_buf_get_name(0), callback = function() <todo> end})")
end

vim.keymap.set('n', "<A-e>", on_demand_autogroup)

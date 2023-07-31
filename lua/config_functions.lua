vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})
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

Copygpg_filename = "" -- not proud of this
local function copygpg()
    local _use_saved = vim.fn.input("Use cached filename? [Y/n] : ")
    local use_saved = (_use_saved ~= "n")
    if ((Copygpg_filename == "") or (not use_saved)) then
        Copygpg_filename = vim.fn.input("Enter path to gpg file : ")
    end
    vim.cmd("silent !copygpg " .. Copygpg_filename)
end

vim.api.nvim_create_user_command("Copygpg", copygpg, {})

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



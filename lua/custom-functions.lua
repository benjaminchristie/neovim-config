M = {}

function M.whereami()
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
    for i = 1, length, 1 do
        vim.fn.timer_start((i + 1) * uptime, function()
            vim.wo.cursorline = true
            vim.wo.cursorcolumn = true
            vim.api.nvim_set_hl(1, "Cursor", { bg = cursor_colors[i] })
            vim.api.nvim_set_hl(1, "CursorLine", { bg = cursor_colors[i] })
            vim.api.nvim_set_hl(1, "CursorColumn", { bg = cursor_colors[i] })
            vim.api.nvim_win_set_hl_ns(vim.api.nvim_get_current_win(), 1)
        end)
        vim.fn.timer_start((length) * uptime + (i + 1) * downtime, function()
            vim.wo.cursorline = true
            vim.wo.cursorcolumn = true
            vim.api.nvim_set_hl(1, "Cursor", { bg = cursor_colors[length - i - 1] })
            vim.api.nvim_set_hl(1, "CursorLine", { bg = cursor_colors[length - i - 1] })
            vim.api.nvim_set_hl(1, "CursorColumn", { bg = cursor_colors[length - i - 1] })
            vim.api.nvim_win_set_hl_ns(vim.api.nvim_get_current_win(), 1)
        end)
        vim.fn.timer_start((length + 1) * (uptime + downtime), function()
            vim.wo.cursorcolumn = false
            vim.o.cursorcolumn = false
            vim.api.nvim_win_set_hl_ns(vim.api.nvim_get_current_win(), 0)
        end)
    end
end

function M.build_func()
    local build_tools = {
        "make ",
        "cmake --build build ",
        "export TERM=dumb && catkin build --no-color --no-status ",
    }
    local prompt = ""
    for i = 1, #build_tools do
        prompt = prompt .. i .. " : " .. build_tools[i] .. "\n"
    end
    prompt = prompt .. "Enter your choice : "
    local which_compiler = vim.fn.input(prompt)
    local idx = tonumber(which_compiler)
    if idx == nil then
        return
    end
    vim.fn.feedkeys(":Dispatch " .. build_tools[idx])
end

--- used for large files or when treesitter + lsp is slow
function M.lazy_load()
    vim.o.syntax = "off"
    vim.lsp.stop_client(vim.lsp.get_clients())
    vim.treesitter.stop()
    vim.diagnostic.hide(nil, 0)
    vim.fn.timer_start(5000, function()
        if vim.treesitter.language.get_lang(vim.o.filetype) ~= nil then
            vim.treesitter.start()
        end
        vim.diagnostic.show(nil, 0)
    end)
end

function M.markdown_preview_function()
    local fn = vim.api.nvim_buf_get_name(0)
    local cached_pdf_fn = vim.fn.stdpath("run") .. "/" .. string.gsub(fn .. ".pdf", "/", "&")
    vim.system(
        { "pandoc", "-V", "geometry:margin=1in", fn, "-o", cached_pdf_fn },
        {},
        function(_) vim.system({ "zathura", cached_pdf_fn }) end
    )
    vim.api.nvim_create_augroup("MarkdownPreview" .. fn, { clear = true })
    vim.api.nvim_create_autocmd({ "BufWrite" }, {
        group = "MarkdownPreview" .. fn,
        pattern = fn,
        callback = function()
            vim.system(
                { "pandoc", "-V", "geometry:margin=1in", fn, "-o", cached_pdf_fn }
            )
        end
    })
end

local zen_enabled = false
function M.toggle_zen()
    zen_enabled = not zen_enabled
    if zen_enabled then
        pcall(vim.api.nvim_del_augroup_by_name, "StatusWinBar")
        for _, winnr in ipairs(vim.api.nvim_list_wins()) do
            vim.api.nvim_win_call(winnr, function()
                vim.o.cmdheight = 0
                vim.o.laststatus = 0
                if not vim.o.diff or not require("statuswinbar").in_diffview_nvim then
                    vim.o.winbar = ""
                end
                vim.o.number = false
                vim.o.relativenumber = false
                vim.o.signcolumn = "no"
                vim.o.showtabline = 0
            end)
        end
        require("ibl").update({ enabled = false })
    else
        for _, winnr in ipairs(vim.api.nvim_list_wins()) do
            vim.api.nvim_win_call(winnr, function()
                vim.o.cmdheight = 1
                vim.o.laststatus = 3
                vim.o.number = true
                vim.o.relativenumber = true
                vim.o.signcolumn = "yes:1"
                vim.o.showtabline = 1
            end)
        end
        require("statuswinbar").setup()
        require("ibl").update({ enabled = true })
    end
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = function()
        local res, ft = pcall(function() return vim.o.filetype end)
        if res and not zen_enabled then
            if ft ~= "oil" and ft ~= "starter" then
                vim.o.number = true
                vim.o.relativenumber = true
            end
        end
    end
})

vim.api.nvim_create_user_command("ZenToggle", M.toggle_zen, {
    desc = "call toggle_zen function"
})
vim.api.nvim_create_user_command("MarkdownPreview", M.markdown_preview_function, {
    desc = "Markdown previewer with pandoc and live updating"
})
vim.keymap.set("n", "<A-l>", M.lazy_load)
vim.api.nvim_create_user_command("LazyLoad", M.lazy_load, { desc = "attempt to lazy load ts and lsp" })
vim.api.nvim_create_augroup("LazyLoadLargeFiles", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    group = "LazyLoadLargeFiles",
    pattern = "*",
    callback = function()
        if vim.fn.getfsize(vim.api.nvim_buf_get_name(0)) > 65536 then
            vim.notify("Lazy loading file...")
            M.lazy_load()
        else
            vim.o.syntax = "on"
            if vim.treesitter.language.get_lang(vim.o.filetype) ~= nil then
                pcall(vim.treesitter.start)
            end
        end
    end
})

vim.api.nvim_create_user_command("Build", M.build_func, { desc = "select build tool for dispatch, then call :Dispatch" })


vim.api.nvim_create_user_command("W", "w", { desc = "alias to :w" })
vim.api.nvim_create_user_command("Q", "q", { desc = "alias to :q" })
vim.api.nvim_create_user_command("TC", "tabclose", { desc = "alias to tabclose" })
vim.api.nvim_create_user_command("TO", "tabclose", { desc = "alias to tabonly" })

vim.api.nvim_create_user_command("Where", M.whereami, { desc = "highlight cursor position" })

vim.api.nvim_create_user_command("Ex", function()
    local HEIGHT = 12
    vim.cmd("topleft Oil")
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.api.nvim_win_set_height(0, HEIGHT)
end, { desc = "open oil above" })

vim.api.nvim_create_user_command("Lex", function()
    local WIDTH = 45
    vim.cmd("vertical Oil")
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.api.nvim_win_set_width(0, WIDTH)
end, { desc = "open oil above" })

vim.api.nvim_create_user_command("Rex", function()
    local WIDTH = 45
    vim.o.splitright = false
    vim.cmd("vertical Oil")
    vim.o.splitright = true
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.api.nvim_win_set_width(0, WIDTH)
end, { desc = "open oil to the left" })
return M

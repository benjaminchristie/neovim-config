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
		local success, res = pcall(vim.treesitter.language.get_lang, vim.bo.filetype)
		if success then
			if res ~= nil then
				vim.bo.syntax = "on"
				pcall(vim.treesitter.start)
			end
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

function M.zen_enabled()
    return zen_enabled
end

function M.toggle_zen()
    zen_enabled = not zen_enabled
    if zen_enabled then
        pcall(vim.api.nvim_del_augroup_by_name, "StatusWinBar")
        pcall(vim.api.nvim_del_augroup_by_name, "StatusWinBarLine")
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

function M.skeletons()
    local skeleton_path = vim.fn.stdpath("config") .. "/skeletons/"
    -- ensure fzf has started
    pcall(require("fzf-lua").register_ui_select)
    vim.ui.select(vim.fn.glob(skeleton_path .. "*", false, true), {
        prompt = "Select skeleton file:",
    }, function(filename)
        vim.cmd("0r " .. filename)
    end)
end

local timers = {}
local search_timer_timeout = 20000
local search_timer_iter = 50
local bg_highlight = "#3E68D7"
local bg_highlight_vals = { '#3B62C8', '#395CBA', '#3655AB', '#344F9C', '#31498E', '#2F437F', '#2C3D71', '#2A3762',
    '#273053', '#252A45', '#222436' }
function M.timed_color_change()
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

-- decrements search, adds nice highlight to words on timeout
function M.decrement_search(cb)
    vim.api.nvim_set_hl(0, "IncSearch", { bg = bg_highlight })
    vim.api.nvim_set_hl(0, "Search", { bg = bg_highlight })
    vim.fn.feedkeys('Nzz', "n")
    if cb ~= nil then
        cb()
    end
end

-- increments search, adds nice highlight to words on timeout
function M.increment_search(cb)
    vim.api.nvim_set_hl(0, "IncSearch", { bg = bg_highlight })
    vim.api.nvim_set_hl(0, "Search", { bg = bg_highlight })
    vim.fn.feedkeys('nzz', "n")
    if cb ~= nil then
        cb()
    end
end

-- change directory to currently opened file
function M.cd_to_cfile(noprint)
    noprint = noprint or (noprint ~= nil)
    local cwd = vim.fn.expand("%:p:h")
    vim.api.nvim_set_current_dir(cwd)
    if not noprint then
        print("Changed cwd to " .. cwd)
    end
end

-- find and replace all words that match the <cword>, while preserving cursor
function M.find_and_replace_all_cword()
    local word = vim.fn.expand("<cword>")
    local line_num = vim.api.nvim_win_get_cursor(0)[1]
    local change_to = vim.fn.input("Change " .. word .. " to : ")
    vim.cmd(':%s/' .. word .. "/" .. change_to .. "/g")
    vim.cmd(":" .. line_num)
end

-- comments a line, preserves the position of the cursor
function M.comment_line_preserve_cursor()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local col_count_pre = vim.fn.strlen(vim.api.nvim_get_current_line())
    vim.cmd("Commentary")
    local col_count_post = vim.fn.strlen(vim.api.nvim_get_current_line())
    local offset = col_count_post - col_count_pre
    cursor_pos[2] = cursor_pos[2] + offset
    vim.api.nvim_win_set_cursor(0, cursor_pos)
end

-- on_demand_autogroup
function M.on_demand_autogroup()
	local f = vim.fn.input("Event(s) to use: ", "BufWrite")
	local c = vim.fn.input("Command to run: ", "Make")
	vim.api.nvim_create_autocmd(f, {
		pattern = vim.api.nvim_buf_get_name(0),
		command = c
	})
end

-- pick the pyenv using ui.select
function M.pick_pyenv()
    return require("swenv.api").pick_venv()
end

vim.api.nvim_create_user_command("Skeletons", M.skeletons, {
    desc = "skeleton picker"
})

vim.api.nvim_create_user_command("PyenvActivate", M.pick_pyenv, {
    desc = "pyenv picker"
})

vim.api.nvim_create_user_command("ZenToggle", M.toggle_zen, {
    desc = "call toggle_zen function"
})

vim.api.nvim_create_user_command("MarkdownPreview", M.markdown_preview_function, {
    desc = "Markdown previewer with pandoc and live updating"
})

vim.api.nvim_create_user_command("Build", M.build_func, { desc = "select build tool for dispatch, then call :Dispatch" })


vim.api.nvim_create_user_command("Where", M.whereami, { desc = "highlight cursor position" })

vim.api.nvim_create_user_command("LazyLoad", M.lazy_load, { desc = "attempt to lazy load ts and lsp" })
vim.api.nvim_create_augroup("LazyLoadLargeFiles", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    group = "LazyLoadLargeFiles",
    pattern = "*",
    callback = function()
        if vim.fn.getfsize(vim.api.nvim_buf_get_name(0)) > 65536 then
            vim.notify("Lazy loading file...")
            vim.schedule(M.lazy_load)
        else
			vim.schedule(function()
				local success, res = pcall(vim.treesitter.language.get_lang, vim.bo.filetype)
				if success then
					if res ~= nil then
						vim.bo.syntax = "on"
						pcall(vim.treesitter.start)
					end
				end
			end)
        end
    end
})

return M

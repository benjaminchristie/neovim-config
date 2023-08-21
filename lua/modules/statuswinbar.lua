---@diagnostic disable: undefined-field
local gitsigns = require("gitsigns")
local parsers = require("nvim-treesitter.parsers")
local ts_utils = require("nvim-treesitter.ts_utils")
local harpoon = require("harpoon.mark")
local force_inactive_filetypes = {
    'NvimTree',
    'dap-repl',
    'dbui',
    'fugitive',
    'fugitiveblame',
    'harpoon',
    'harpoon-menu',
    'nofile',
    'oil',
    'packer',
    'qf',
    'starter',
    'startify',
    'terminal',
    'toggleterm',
}

local force_inactive_buftypes = {
    'harpoon',
    'harpoon-menu',
    'nofile',
    'nowrite',
    'prompt',
    'quickfix',
    'terminal',
    'toggleterm',
}

local function hasvalue(table, value)
    for _, val in ipairs(table) do
        if val == value then
            return true
        end
    end
    return false
end

local function get_clients()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then
        return ""
    else
        local tb = {
            "%#WinBarLSP#",
            clients[1]["name"],
        }
        return table.concat(tb, "")
    end
end

local function get_changed_hunks()
    local branch = vim.b.gitsigns_head
    if branch ~= nil then
        local hunks_tb = gitsigns.get_hunks(vim.api.nvim_get_current_buf())
        local added_count = "0"
        local removed_count = "0"
        if hunks_tb ~= nil then
            for _, hunks in pairs(hunks_tb) do
                if hunks["added"] ~= nil then
                    added_count = hunks["added"]["count"]
                end
                if hunks["removed"] ~= nil then
                    removed_count = hunks["removed"]["count"]
                end
            end
        end
        local tb = {
            "%#WinBarGit#",
            "  ",
            branch,
            "%#WinBarGitAdded#",
            " +",
            added_count,
            "%#WinBarGitSubbed#",
            " -",
            removed_count,
        }
        return table.concat(tb, "")
    else
        return ""
    end
end

local function get_harpoon_idx()
    local harpoon_idx = harpoon.get_current_index()
    if harpoon_idx ~= nil then
        local tb = {
            "%#WinBarHarpoon#",
            "🡕  ",
            harpoon_idx,
            " "
        }
        return table.concat(tb, "")
    else
        return ""
    end
end


local function winbarstring()
    local path = vim.fn.expand("%:f")
    return string.format("%s %s %s %s", path, get_harpoon_idx(), get_changed_hunks(), get_clients())
end
vim.api.nvim_create_autocmd('User', {
    pattern = 'GitSignsUpdate',
    callback = function()
        if hasvalue(force_inactive_buftypes, vim.bo.buftype) or hasvalue(force_inactive_filetypes, vim.bo.filetype) then
            vim.opt_local.winbar = nil
        else
            vim.opt_local.winbar = winbarstring()
        end
    end
})
vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged", "LspAttach" }, {
    pattern = "*",
    callback = function()
        gitsigns.refresh()
        if hasvalue(force_inactive_buftypes, vim.bo.buftype) or hasvalue(force_inactive_filetypes, vim.bo.filetype) then
            vim.opt_local.winbar = nil
        else
            vim.opt_local.winbar = winbarstring()
        end
    end
})


-- Trim spaces and opening brackets from end
local transform_line = function(line)
    return line:gsub("%s*[%[%(%{]*%s*$", "")
end

local function trimmed_ts_statusline(opts)
    if not parsers.has_parser() then
        return
    end
    local options = opts or {}
    if type(opts) == "number" then
        options = { indicator_size = opts }
    end
    local bufnr = options.bufnr or 0
    local type_patterns = options.type_patterns or { "class", "function", "method", "struct" }
    local transform_fn = options.transform_fn or transform_line
    local allow_duplicates = options.allow_duplicates or false

    local current_node = ts_utils.get_node_at_cursor()
    if not current_node then
        return ""
    end

    local lines = {}
    local expr = current_node

    while expr do
        local line = ts_utils._get_line_for_node(expr, type_patterns, transform_fn, bufnr)
        if line ~= "" then
            if allow_duplicates or not vim.tbl_contains(lines, line) then
                table.insert(lines, 1, line)
            end
        end
        expr = expr:parent()
    end

    if lines[1] == nil then
        return ""
    end

    return lines[1]
end
function MyFunc()
    local x = string.format("[%s] - %s", vim.bo.filetype, vim.fn.bufnr())
    if not (hasvalue(force_inactive_buftypes, vim.bo.buftype) or hasvalue(force_inactive_filetypes, vim.bo.filetype)) then
        local status = trimmed_ts_statusline()
        if status ~= "" and status ~= nil then
            return x .. "%#StatusLineNC# : ̗̀➛ " .. status
        end
    end
    return x
end

vim.o.showtabline = 1
vim.o.laststatus = 3
vim.api.nvim_create_autocmd({ "BufEnter", "CursorMoved" }, {
    pattern = "*",
    callback = function()
        vim.opt_local.statusline = "%!v:lua.MyFunc()"
    end
})
vim.api.nvim_create_autocmd({ "BufLeave" }, {
    pattern = "*",
    callback = function()
        vim.opt_local.statusline = string.format("[%s] - %s", vim.bo.filetype, vim.fn.bufnr())
    end
})

local utils = {}

-- Returns true if value exists in table
-- 
-- {what}       Type    Description ~
-- t           table   table to search
-- v           value   value to check for in table
utils.exists_in_table = function (table, value)
    for _, v_t in ipairs(table) do
        if v_t == value then
            return true
        end
    end
    return false
end

-- Returns t1 merged with the values of t2
-- 
-- {what}       Type    Description ~
-- t1           table   table to insert *into*
-- t2           table   table to insert *from*
utils.merge_tables = function (t1, t2)
    for _, v in ipairs(t2) do
        table.insert(t1, v)
    end
    return t1
end

-- Creates an autogroup with clear = true
--
-- {what}       Type    Description ~
-- group        string  group to set
utils.augroup = function (group)
   return vim.api.nvim_create_augroup(group, { clear = true })
end

-- Wrapper for vim.keymap.set
--
-- {what}       Type           Description ~
-- mode        string          Mode to use for keymap
-- key         string          Key to use for keymap
-- cmd     string | function   callback
-- opts?    table | nil        optional, override default options
utils.keymap = function (mode, key, cmd, opts)
    if opts == nil then
        opts = {nowait = false, silent = true}
    end
    return vim.keymap.set(mode, key, cmd, opts)
end

-- Creates a keymap local to the buffer
--
-- {what}       Type           Description ~
-- key         string          Key to use for keymap
-- cmd     string | function   callback
-- opts?    table | nil        optional, override default options
utils.buf_keymap = function (key, cmd, opts)
    if opts == nil then
        opts = {buffer = vim.fn.bufnr(), nowait = true, silent = true}
    end
    return utils.keymap("n", key, cmd, opts)
end


return utils

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




return utils

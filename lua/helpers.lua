--- General 'helper' utilities for scripts to use.

local M = {}

local os_name = vim.loop.os_uname().sysname

--- The OS we're running on.
M.os = {
    macOS = (os_name == 'Darwin'),
    linux = (os_name == 'Linux')
}

--- Get the list of keys in a table.
--- @param tbl table
M.table_keys = function(tbl)
    local keys = {}

    for key, _ in pairs(tbl) do
        table.insert(keys, key)
    end

    return keys
end

return M

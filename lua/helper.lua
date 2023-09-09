--- Get the OS we're on
local function get_os()
    local os_name = vim.loop.os_uname().sysname

    return {
        macOS = os_name == 'Darwin',
        linux = os_name == 'Linux'
    }
end

--- Get the keys in a table
--- @param tbl table
local function table_keys(tbl)
    local keys = {}

    for key, _ in pairs(tbl) do
        table.insert(keys, key)
    end

    return keys
end

return {
    os = get_os(),
    table_keys = table_keys
}

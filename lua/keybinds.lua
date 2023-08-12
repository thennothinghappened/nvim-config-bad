-- Keybind options
local function opts(desc)
    return {
        desc = desc,
        buffer = buf_number,
        noremap = true,
        silent = true,
        nowait = true
    }
end

-- General keybinds
local function general()
    vim.go.whichwrap = 'b,s,<,>,[,]'
end

return {
    -- Keybinds for nvim-tree
    nvim_tree = function ()
        vim.keymap.set('n', 'T', '<Cmd>NvimTreeToggle<CR>', opts('Nvim-Tree: Toggle Tree'))
    end,

    -- General keybinds
    general = general
}

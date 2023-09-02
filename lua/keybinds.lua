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

-- Neovide-specific (fix MacOS paste)
local function neovide()
    --vim.keymap.set('', '<D-v>', '+p<CR>', opts('Neovide: MacOS clipboard'))
    vim.g.neovide_input_use_logo = 1
    vim.api.nvim_set_keymap('', '<D-v>', 'p<CR>', { noremap = true, silent = true})
    vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true})
    vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true})
    vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true})
end

return {
    -- Keybinds for nvim-tree
    nvim_tree = function ()
        vim.keymap.set('n', 'T', '<Cmd>NvimTreeToggle<CR>', opts('Nvim-Tree: Toggle Tree'))
    end,

    -- General keybinds
    general = general,

    -- Neovide
    neovide = neovide
}

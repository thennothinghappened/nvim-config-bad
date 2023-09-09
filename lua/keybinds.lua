local os = require('helper').os

--- General keybinds
local function general()
    -- Set wrap behaviour for arrowing around
    vim.go.whichwrap = 'b,s,<,>,[,]'

    -- Blasphemy
    if os.macOS then
        -- Command-Z undo
        vim.keymap.set({ '', 't' }, '<D-z>', 'u', { silent = true })
        vim.keymap.set('i', '<D-z>', '<C-o>:u<CR>', { silent = true })

        -- Command-Shift-Z redo
        -- TODO: this doesn't work :(
        vim.keymap.set('', '<D-S-v>', '<C-r>', { silent = true })
        vim.keymap.set('!', '<D-S-v>', '<C-o>:<C-r><CR>', { silent = true })
    end
end

--- Neovide-specific (fix MacOS paste)
local function neovide()
    if os.macOS then
        vim.g.neovide_input_use_logo = 1

        vim.keymap.set('', '<D-v>', 'p<CR>', { silent = true, nowait = true })
        vim.keymap.set({ '!', 'v' }, '<D-v>', '<C-R>+', { silent = true, nowait = true })
    end
end

return {
    -- Keybinds for nvim-tree
    nvim_tree = function()
        -- Toggle tree in normal mode
        vim.keymap.set('n', 'T', '<Cmd>NvimTreeToggle<CR>', { silent = true, nowait = true })
    end,

    -- General keybinds
    general = general,

    -- Neovide
    neovide = neovide
}

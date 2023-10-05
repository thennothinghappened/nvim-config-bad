------------------------
--- Neovide-specific ---
------------------------

local normal = require('helper').normal

if vim.g.neovide then
    -- fix MacOS copy/paste
    if  os.macOS then
        vim.g.neovide_input_use_logo = 1

        -- Paste
        vim.keymap.set('', '<D-v>', 'p', { silent = true, nowait = true })
        vim.keymap.set('!', '<D-v>', normal .. 'p', { silent = true, nowait = true })
    end
end

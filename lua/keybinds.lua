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

        -- Command-A select all
        vim.keymap.set('n', '<D-a>', 'ggVG', { silent = true })
        vim.keymap.set('v', '<D-a>', 'gg0oG$', { silent = true })
        vim.keymap.set('!', '<D-a>', '<C-Home><C-O>VG', { silent = true })
    end
end

--- Right click menu
local function rightclick()
    -- Remove placeholder
    vim.cmd.aunmenu { 'PopUp.How-to\\ disable\\ mouse' }

    -- Add our items

    -- LSP references
    vim.cmd.anoremenu { 'PopUp.Documentation', ':lua require(\'hover\').hover()<CR>' }
    vim.cmd.anoremenu { 'PopUp.Goto\\ Definition', ':lua vim.lsp.buf.definition()<CR>' }
    vim.cmd.anoremenu { 'PopUp.References', ':lua vim.lsp.buf.references()<CR>' }
    vim.cmd.anoremenu { 'PopUp.Rename', ':lua vim.lsp.buf.rename()<CR>' }

    -- LSP format file
    vim.cmd.anoremenu { 'PopUp.-2-', '<Nop>' }
    vim.cmd.anoremenu { 'PopUp.Format\\ file', ':lua vim.lsp.buf.format()<CR>' }
end

--- Neovide-specific (fix MacOS copy/paste)
local function neovide()
    if os.macOS then
        vim.g.neovide_input_use_logo = 1

        -- Copy
        vim.keymap.set('v', '<D-c>', 'y', { silent = true, nowait = true })

        -- Paste
        vim.keymap.set('', '<D-v>', 'p<CR>', { silent = true, nowait = true })
        vim.keymap.set({ '!', 'v' }, '<D-v>', '<C-R>+', { silent = true, nowait = true })
    end
end

--- Keybinds for nvim-tree
local function nvim_tree()
    -- Toggle tree in normal mode
    vim.keymap.set('n', 'T', '<Cmd>NvimTreeToggle<CR>', { silent = true, nowait = true })
end

return {
    -- Keybinds for nvim-tree
    nvim_tree = nvim_tree,

    -- General keybinds
    general = general,
    rightclick = rightclick,

    -- Neovide
    neovide = neovide
}

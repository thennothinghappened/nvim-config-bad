local os = require('helper').os

local normal = '<C-o>'

--- General keybinds
local function general()
    -- Set wrap behaviour for arrowing around
    vim.go.whichwrap = 'b,s,<,>,[,]'

    -- Custom binds
    vim.g.mapleader = ' '
end

--- Right click menu
local function rightclick()

    local div_index = 2
    --- Add a divider
    --- @param modes table<string>
    local function div(modes)
        for _, mode in pairs(modes) do
            vim.cmd[mode .. 'noremenu'] { 'PopUp.-' .. div_index .. '-', '<Nop>' }
        end
        div_index = div_index + 1
    end

    -- Remove placeholder
    vim.cmd.aunmenu { 'PopUp.How-to\\ disable\\ mouse' }

    --- Add our items ---

    -- LSP references
    vim.cmd.anoremenu { 'PopUp.Documentation', ':lua require(\'hover\').hover()<CR>' }
    vim.cmd.anoremenu { 'PopUp.Goto\\ Definition', ':lua vim.lsp.buf.definition()<CR>' }
    vim.cmd.anoremenu { 'PopUp.References', ':lua vim.lsp.buf.references()<CR>' }
    vim.cmd.anoremenu { 'PopUp.Rename', ':lua vim.lsp.buf.rename()<CR>' }

    -- LSP format file
    div { 'n' }
    vim.cmd.nnoremenu { 'PopUp.Format\\ file', ':lua vim.lsp.buf.format()<CR>' }

    -- Comment
    div { 'i', 'n', 'v' }
    local comment_binds = require('plugins/comment').binds

    vim.cmd.vmenu { 'PopUp.Toggle\\ comment', comment_binds.visual.line }
    vim.cmd.nmenu { 'PopUp.Toggle\\ comment', comment_binds.normal.line }
    vim.cmd.imenu { 'PopUp.Toggle\\ comment', normal .. comment_binds.normal.line }
end

--- Neovide-specific (fix MacOS copy/paste)
local function neovide()
    if os.macOS then
        vim.g.neovide_input_use_logo = 1

        -- Copy
        vim.keymap.set('v', '<D-c>', 'y', { silent = true, nowait = true })

        -- Paste
        vim.keymap.set('', '<D-v>', 'p', { silent = true, nowait = true })
        vim.keymap.set('!', '<D-v>', normal .. 'p', { silent = true, nowait = true })
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
    neovide = neovide,

    -- Comment
    comment = comment
}

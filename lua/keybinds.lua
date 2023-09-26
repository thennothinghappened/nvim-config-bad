local os = require('helper').os

local normal = '<C-o>'

-- Custom binds
vim.g.mapleader = ' '

------------------------
---     Telescope    ---
------------------------
local telescope = {
    builtin = require('telescope.builtin')
}

vim.keymap.set('', '<leader>f', telescope.builtin.git_files)
vim.keymap.set('', '<leader>g', telescope.builtin.live_grep)
vim.keymap.set('', '<leader>d', telescope.builtin.lsp_definitions)
vim.keymap.set('', '<leader>r', telescope.builtin.lsp_references)
vim.keymap.set('', '<leader>w', telescope.builtin.buffers)
vim.keymap.set('', '<leader>e', telescope.builtin.diagnostics)

------------------------
--- Neovide-specific ---
------------------------

if vim.g.neovide then
    -- fix MacOS copy/paste
    if  os.macOS then
        vim.g.neovide_input_use_logo = 1

        -- Paste
        vim.keymap.set('', '<D-v>', 'p', { silent = true, nowait = true })
        vim.keymap.set('!', '<D-v>', normal .. 'p', { silent = true, nowait = true })
    end
end

------------------------
--- Right click menu ---
------------------------

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

-- jank
vim.cmd.vmenu { 'PopUp.Toggle\\ comment', comment_binds.visual.line }
vim.cmd.nmenu { 'PopUp.Toggle\\ comment', comment_binds.normal.line }
vim.cmd.imenu { 'PopUp.Toggle\\ comment', normal .. comment_binds.normal.line }

------------------------
---     nvim-tree    ---
------------------------

vim.keymap.set('n', 'T', '<Cmd>NvimTreeToggle<CR>', { silent = true, nowait = true })


------------------------
---      barbar      ---
------------------------

vim.keymap.set('n', '<leader>i', '<Cmd>BufferPrevious<CR>')
vim.keymap.set('n', '<leader>o', '<Cmd>BufferNext<CR>')
vim.keymap.set('n', '<leader>q', '<Cmd>BufferClose<CR>')

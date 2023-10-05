------------------------
--- Right click menu ---
------------------------

local normal = require('helper').normal

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

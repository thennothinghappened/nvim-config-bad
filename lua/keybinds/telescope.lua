------------------------
---     Telescope    ---
------------------------
local telescope = {
    builtin = require('telescope.builtin')
}

vim.keymap.set('', '<leader>f', telescope.builtin.git_files, { desc = 'Telescope Git files' })
vim.keymap.set('', '<leader>g', telescope.builtin.live_grep, { desc = 'Telescope grep' })
vim.keymap.set('', '<leader>d', telescope.builtin.lsp_definitions, { desc = 'Telescope LSP definition' })
vim.keymap.set('', '<leader>r', telescope.builtin.lsp_references, { desc = 'Telescope LSP references' })
vim.keymap.set('', '<leader>w', telescope.builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('', '<leader>e', telescope.builtin.diagnostics, { desc = 'Telescope LSP diagnostics' })
vim.keymap.set('', '<leader>T', telescope.builtin.builtin, { desc = 'Telescope' })

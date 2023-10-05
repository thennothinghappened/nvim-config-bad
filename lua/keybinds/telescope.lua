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

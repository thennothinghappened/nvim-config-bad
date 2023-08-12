local keybinds = require('keybinds')

require('plugins/lazy').setup({
    -- Atom One Dark
    {
        'navarasu/onedark.nvim',
        lazy = true
    },
    -- Indentation guides
    { 'lukas-reineke/indent-blankline.nvim' },
    -- File Tree
    require('plugins/nvim-tree'),
    -- Syntax highlighting
    require('plugins/nvim-treesitter'),
    -- Tabs
    require('plugins/barbar'),
    -- Nice info line :)
    require('plugins/lualine')
})

-- colorscheme
vim.cmd.colorscheme('onedark')
-- line numbers
vim.wo.number = true
-- scroll speed
vim.go.mousescroll = 'ver:1,hor:2'
-- indentation
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
-- clipboard
vim.go.clipboard = 'unnamedplus'


-- Init all keybinds
keybinds.nvim_tree()
keybinds.general()

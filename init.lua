local keybinds = require('keybinds')

require('plugins/lazy').setup({
    -- Atom One Dark
    {
        'navarasu/onedark.nvim',
        lazy = true
    },
    -- Indentation guides
    { 'lukas-reineke/indent-blankline.nvim' },
    -- Rainbow brackets
    { 'hiphish/rainbow-delimiters.nvim' },
    -- File Tree
    require('plugins/nvim-tree'),
    -- Syntax highlighting
    require('plugins/nvim-treesitter'),
    -- Tabs
    require('plugins/barbar'),
    -- Nice info line :)
    require('plugins/lualine'),
    -- LSP
    require('plugins/mason'),
    require('plugins/mason-lspconfig'),
    require('plugins/nvim-lspconfig'),
    require('plugins/nvim-cmp'),
    require('plugins/hover'),
    -- Code folding
    require('plugins/nvim-ufo'),
    -- Autopairs
    require('plugins/autopairs'),
    -- Writing protected files
    { 'lambdalisue/suda.vim' },
    -- Comment utils
    require('plugins/comment')
})

-- Options
require('opts')

-- Init all keybinds
keybinds.nvim_tree()
keybinds.general()
keybinds.rightclick()
keybinds.comment()

if vim.g.neovide then
    keybinds.neovide()
end

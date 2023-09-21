require('plugins/lazy').setup({
    {
        'navarasu/onedark.nvim',
        lazy = true
    },

    { 'lukas-reineke/indent-blankline.nvim' },

    { 'hiphish/rainbow-delimiters.nvim' },

    require('plugins/nvim-tree'),

    require('plugins/nvim-treesitter'),

    require('plugins/lualine'),

    -- LSP
    require('plugins/mason'),
    require('plugins/mason-lspconfig'),
    require('plugins/nvim-lspconfig'),
    require('plugins/nvim-cmp'),
    require('plugins/hover'),

    require('plugins/telescope'),

    require('plugins/nvim-ufo'),

    require('plugins/autopairs'),

    { 'lambdalisue/suda.vim' },

    require('plugins/comment'),

    require('plugins/barbar')
})

require('opts')
require('keybinds')

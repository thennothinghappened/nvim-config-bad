require('plugins/lazy').setup({
    require('plugins/themes/onedark'),
    require('plugins/themes/oxocarbon'),
    require('plugins/themes/kanagawa'),

    -- { 'lukas-reineke/indent-blankline.nvim' },
    --
    -- { 'hiphish/rainbow-delimiters.nvim' },

    require('plugins/nvim-tree'),

    require('plugins/nvim-treesitter'),

    require('plugins/lualine'),

    -- LSP
    require('plugins/mason'),
    require('plugins/mason-lspconfig'),
    require('plugins/nvim-lspconfig'),
    require('plugins/nvim-cmp'),
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
        config = function(_, opts)
            require('lsp_signature').setup(opts)
        end
    },
    require('plugins/hover'),

    require('plugins/telescope'),

    require('plugins/nvim-ufo'),

    require('plugins/autopairs'),

    { 'lambdalisue/suda.vim' },

    require('plugins/comment'),

    require('plugins/barbar'),

    require('plugins/gitsigns')
})

require('opts')
require('keybinds')

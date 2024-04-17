
-- This config really needs to start from scratch, this is horrendous.

require('plugins.lazy').setup({
    require('plugins.themes.themes'),

    -- { 'lukas-reineke.indent-blankline.nvim' },
    --
    -- { 'hiphish.rainbow-delimiters.nvim' },

    require('plugins.nvim-tree'),

    require('plugins.treesitter.nvim-treesitter'),
    require('plugins.treesitter.nvim-ufo'),

    require('plugins.lualine'),

    require('plugins.lsp.lsp'),

    require('plugins.telescope'),

    require('plugins.autopairs'),

    { 'lambdalisue/suda.vim' },

    require('plugins.comment'),

    require('plugins.barbar'),

    require('plugins.gitsigns'),

    require('plugins.whichkey'),

})

require('opts')
require('keybinds')

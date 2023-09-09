return {
    'lewis6991/hover.nvim',

    dependencies = {
        'nvim-cmp'
    },

    opts = {
        init = function()
            require('hover.providers.lsp')
        end
    }
}

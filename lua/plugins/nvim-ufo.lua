return {
    'kevinhwang91/nvim-ufo',

    dependencies = { 'kevinhwang91/promise-async' },

    config = function()

        require('ufo').setup()

        vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
        vim.o.foldcolumn = '3'
        vim.wo.foldlevel = 99

    end
}

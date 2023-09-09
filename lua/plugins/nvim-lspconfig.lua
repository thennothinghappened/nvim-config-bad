return {
    'neovim/nvim-lspconfig',

    dependencies = {
        'williamboman/mason-lspconfig.nvim',
    },

    config = function()

        vim.diagnostic.config({
            -- Self-explanatory!
            update_in_insert = true
        })

        require('../lsp-shared').icons_config()

    end
}

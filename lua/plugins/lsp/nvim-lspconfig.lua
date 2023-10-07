return function (icons_config)
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

            icons_config()

        end
    }
end

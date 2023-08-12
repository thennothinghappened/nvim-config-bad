return {
    'neovim/nvim-lspconfig',
    dependencies = {
        {
            'williamboman/mason.nvim',
            config = function()
                require('mason').setup()
            end
        },
        {
            'williamboman/mason-lspconfig.nvim',
            dependencies = {

            },
            config = function()
                require('mason-lspconfig').setup({
                    ensure_installed = {
                        'lua_ls',
                        'rust_analyzer',
                        'clangd',
                        'cssls',
                        'html',
                        'tsserver'
                    }
                })
            end
        }
    },
    config = function()

        vim.diagnostic.config({
            update_in_insert = true
        })

        -- Icons ( https://github.com/folke/trouble.nvim/issues/52#issuecomment-988874117 )
        for type, icon in pairs({
            Error   = ' ',
            Warn    = ' ',
            Hint    = ' ',
            Info    = ' '
        }) do
            local name = 'DiagnosticSign' .. type
            vim.fn.sign_define(name, { text = icon, texthl = name, numhl = name })
        end
    end
}

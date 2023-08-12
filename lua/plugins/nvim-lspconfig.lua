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
    }
}

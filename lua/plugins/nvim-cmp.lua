return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp'
    },
    opts = {
        sources = {
            { name = 'nvim_lsp' }
        }
    },
    config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local lspconfig = require('lspconfig')

        lspconfig.rust_analyzer.setup({ capabilities = capabilities })
        lspconfig.lua_ls.setup({ capabilities = capabilities })
        lspconfig.clangd.setup({ capabilities = capabilities })
        lspconfig.cssls.setup({ capabilities = capabilities })
        lspconfig.html.setup({ capabilities = capabilities })
        lspconfig.tsserver.setup({ capabilities = capabilities })
    end
}

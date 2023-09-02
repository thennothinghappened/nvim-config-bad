return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'onsails/lspkind.nvim'
    },
    config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local lspconfig = require('lspconfig')
        local cmp = require('cmp')
        local lspkind = require('lspkind')

        -- https://github.com/hrsh7th/nvim-cmp/issues/373#issuecomment-1434284568
        capabilities.textDocument.completion.completionItem.snippetSupport = false

        lspconfig.rust_analyzer.setup { capabilities = capabilities }
        lspconfig.lua_ls.setup { capabilities = capabilities }
        lspconfig.clangd.setup { capabilities = capabilities }
        lspconfig.cssls.setup { capabilities = capabilities }
        lspconfig.html.setup { capabilities = capabilities }
        lspconfig.tsserver.setup { capabilities = capabilities }

        cmp.setup({
            sources = {
                { name = 'nvim_lsp' },
                { name = 'path' }
            },
            formatting = {
                format = lspkind.cmp_format {
                    mode = 'symbol',
                    maxwidth = 50,
                    ellipsis_char = '...',
                    before = function(entry, vim_item)
                        return vim_item
                    end
                }
            },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert({
               ['<C-b>'] = cmp.mapping.scroll_docs(-1),
               ['<C-f>'] = cmp.mapping.scroll_docs( 1),
               ['<C-Space>'] = cmp.mapping.complete(),
               ['<C-e>'] = cmp.mapping.abort(),
               ['<CR>'] = cmp.mapping.confirm({ select = true })
             })
        })
    end
}

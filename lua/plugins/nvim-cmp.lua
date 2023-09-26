return {
    'hrsh7th/nvim-cmp',

    dependencies = {
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'saadparwaiz1/cmp_luasnip',
        {
            'L3MON4D3/LuaSnip',

            dependencies = {
                'saadparwaiz1/cmp_luasnip',
            },

            config = function ()
                local luasnip = require 'luasnip'
                require('luasnip.loaders.from_vscode').lazy_load()
                luasnip.config.setup {}
            end
        },
        'onsails/lspkind.nvim'
    },

    config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        local lspconfig = require('lspconfig')
        local cmp = require('cmp')
        local lspkind = require('lspkind')
        local luasnip = require('luasnip')

        -- ufo
        -- would like to move this where it more belongs, but oh well.
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }

        -- Init servers
        for server, config in pairs(require('../lsp-shared').servers) do
            config.capabilities = capabilities
            lspconfig[server].setup(config)
        end

        cmp.setup({
            sources = {
                { name = 'nvim_lsp' },
                { name = 'path' },
                { name = 'luasnip' }
            },

            formatting = {
                format = lspkind.cmp_format {
                    mode = 'symbol',
                    maxwidth = 50,
                    ellipsis_char = '...'
                }
            },

            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },

            mapping = cmp.mapping.preset.insert({
                -- Trackpad-optimised scroll speed
                ['<C-b>'] = cmp.mapping.scroll_docs(-1),
                ['<C-f>'] = cmp.mapping.scroll_docs( 1),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                -- Select the current choice on enter
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                -- Scrolling options
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            })
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
        })
    end
}

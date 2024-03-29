return function(servers, bindings)
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

                config = function()
                    local luasnip = require('luasnip')

                    require('luasnip.loaders.from_vscode').lazy_load({
                        paths = {
                            vim.fn.stdpath('config') .. '/snippets',
                        }
                    })

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

            local function on_attach(client, bufnr)
                bindings.bindingsLSPAttach(bufnr)
            end

            -- Init servers
            for server, config in pairs(servers) do
                config.capabilities = capabilities
                config.on_attach = on_attach
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

                mapping = bindings.bindingsCmp(cmp)
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
end

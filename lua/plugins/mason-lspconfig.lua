local servers = require('../lsp-shared').servers
local table_keys = require('../helper').table_keys

return {
    'williamboman/mason-lspconfig.nvim',

    dependencies = {
        'williamboman/mason.nvim'
    },

    opts = {
        ensure_installed = table_keys(servers)
    }
}

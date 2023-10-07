return function(server_names)
    return {
        'williamboman/mason-lspconfig.nvim',

        dependencies = {
            'williamboman/mason.nvim'
        },

        opts = {
            ensure_installed = server_names
        }
    }
end

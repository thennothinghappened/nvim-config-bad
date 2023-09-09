--- Icons:
--- https://github.com/folke/trouble.nvim/issues/52#issuecomment-988874117
local function icons_config()
    for type, icon in pairs({
        Error   = ' ',
        Warn    = ' ',
        Hint    = ' ',
        Info    = ' '
    }) do
        local name = 'DiagnosticSign' .. type

        vim.fn.sign_define(
            name,
            {
                text = icon,
                texthl = name,
                numhl = name
            }
        )
    end
end

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

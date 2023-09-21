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

-- Shared across LSP plugins
return {
    -- Configuration of the LSP servers we need
    servers = {
        lua_ls = {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }
                    }
                }
            }
        },
        rust_analyzer = {},
        clangd = {},
        cssls = {},
        html = {},
        tsserver = {}
    },

    -- Helper to setup icons
    icons_config = icons_config
}

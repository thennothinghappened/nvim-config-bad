local table_keys = require('helper').table_keys
local shared = require('plugins.lsp.lsp-shared')
local bindings = require('keybinds.lsp')

return {
    require('plugins.lsp.mason'),
    require('plugins.lsp.mason-lspconfig')(table_keys(shared.servers)),
    require('plugins.lsp.nvim-lspconfig')(shared.icons_config),
    require('plugins.lsp.nvim-cmp')(shared.servers, bindings),
    require('plugins.lsp.lsp-signature'),
    require('plugins.lsp.hover')
}
